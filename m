Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWBOH5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWBOH5T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 02:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422682AbWBOH5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 02:57:18 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:17065 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S1751016AbWBOH5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 02:57:18 -0500
thread-index: AcYyBWmePrcLQpWsTpycSvAqqw+2zQ==
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Message-ID: <43F2DED2.6070704@bfh.ch>
Date: Wed, 15 Feb 2006 08:57:06 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <58cb370e0602130156k10dff232o46b46e7030a504ee@mail.gmail.com>
In-Reply-To: <58cb370e0602130156k10dff232o46b46e7030a504ee@mail.gmail.com>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2006 07:57:05.0131 (UTC) FILETIME=[69685BB0:01C63205]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bartlomiej Zolnierkiewicz wrote:
>>
>>Q1: Yes or No?
>>If no, the other questions do not apply
> 
> 
> Yes?
> 
> 
>>Q2: Where under sysfs?
>>Either do /sys/block/hdx/heads, /sys/block/hdx/sectors, etc. or should
>>there be a new sub-object like /sys/block/hdx/geometry/heads?
> 
> 
> IMO /sys/block/hdx/sectors could be misleading
> therefore /sys/block/hdx/geometry/ would be better
> 
> 
>>Q3: Writable?
>>Under some (weird) circumstances it would actually be quite nice to
>>overwrite the kernels idea of a disks geometry. This would require a
>>general function like setgeo. Acceptable?
> 
> 
> Don't know.  Maybe you should make it into separate patch
> (incremental to basic functionality) so it can be decided later.
> 
> Cheers,
> Bartlomiej

Hi Bartlomiej

Thanks for your feedback. I'm currently testing the read export and it
seems to work fine.

If possible i'd like your opinion about how to implement write support.
I see 3 possibilities:
-Extend the gendisk struct by geometry information. If the user
overwrites the geometry, values from there are returned instead of
calling getgeo. This is the easiest way, because nothing has to be done
with subsystem drivers. On the other hand, if by chance a driver really
uses the geometry values he'll never know...
-Introduce a setgeo function as a companion to getgeo. Values under
sysfs will only be writable if the underlying drivers supplies this and
all writes will be delegated there. Drawback: Driver maintainers need to
think about this.
-The third way would be to combine both. Store the geometry in gendisk
if no setgeo is provided...

What do you think?

Thank you
Philippe Seewer
