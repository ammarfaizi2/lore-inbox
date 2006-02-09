Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422917AbWBIRPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422917AbWBIRPZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422919AbWBIRPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:15:25 -0500
Received: from mail.gmx.de ([213.165.64.21]:14314 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422917AbWBIRPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:15:24 -0500
X-Authenticated: #428038
Message-ID: <43EB78AA.6040708@gmx.de>
Date: Thu, 09 Feb 2006 18:15:22 +0100
From: Matthias Andree <matthias.andree@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Joerg Schilling <schilling@fokus.fraunhofer.de>, jim@why.dont.jablowme.net,
       peter.read@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner> <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner> <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> Please explain me:
>>
>> -	how to use /dev/hd* in order to scan an image from a scanner
>> -	how to use /dev/hd* in order to talk to a CPU device
>> -	how to use /dev/hd* in order to talk to a tape device
>> -	how to use /dev/hd* in order to talk to a printer
>> -	how to use /dev/hd* in order to talk to a jukebox
>> -	how to use /dev/hd* in order to talk to a graphical device

> With /dev/sg, this was possible?

Theoretically, yes, provided there was an application talking raw SCSI to
the device in question. /dev/sg is a generic SCSI device that allows the
sending of commands. It does not implement higher-level device models such
as direct access (/dev/sd*), CD-ROM (/dev/sr*), sequential access
(/dev/[n]st*) or similar. It's kind of "raw SCSI".

OTOH, there is, according to kernel developers, no difference between
/dev/sg and /dev/hd for SCSI command access via the SG_IO ioctl, so unless
someone documents /dev/hd* bugs that /dev/sg* doesn't share, it appears as
though the user space would have to live with a /dev/hd* that unifies the
mid-level "raw SCSI command" and the high-level (block device) access.
