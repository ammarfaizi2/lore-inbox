Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266309AbUAVVIL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 16:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266331AbUAVVIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 16:08:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39883 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266309AbUAVVII
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 16:08:08 -0500
Message-ID: <40103BAB.4080601@pobox.com>
Date: Thu, 22 Jan 2004 16:07:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "James H. Cloos Jr." <cloos@jhcloos.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Shutdown IDE before powering off.
References: <1074735774.31963.82.camel@laptop-linux>	<20040121234956.557d8a40.akpm@osdl.org>	<200401220813.i0M8DX4Q000511@81-2-122-30.bradfords.org.uk> <m3y8rzlrj5.fsf@lugabout.jhcloos.org>
In-Reply-To: <m3y8rzlrj5.fsf@lugabout.jhcloos.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James H. Cloos Jr. wrote:
>>>>>>"John" == John Bradford <john@grabjohn.com> writes:
> 
> 
>>>This spins down the disk(s) when you're just doing do a reboot.
>>>That's fairly irritating and could affect reboot times if one has
>>>many disks.
> 
> 
> John> I think it is an attempt to force some broken drives to flush
> John> their cache, but I wonder whether it will simply move the
> John> problem from one set of broken drives to another :-).
> 
> It will.  I've had to work with a few drives or drive combos over
> the years that would not spin up reliably.  It was vital to keep
> them spinning once they were (all) up.  Adding this would make
> reboot unnecessarily unuseable in such cases.  Perhaps just
> flush, pause, flush would work as well?


Flush is what is needed, flush is what it does in 2.4, and flush is what 
it should do in 2.6 :)

Rebooting does not shut down nor unload the IDE driver, so it is 
-critical- that a flush occurs before reboot, otherwise it is entirely 
possible that writes the drive has ack'd back to the OS will not 
actually get written to the media.

	Jeff



