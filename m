Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264714AbSKSMnH>; Tue, 19 Nov 2002 07:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbSKSMnH>; Tue, 19 Nov 2002 07:43:07 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:28087 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264714AbSKSMnG>; Tue, 19 Nov 2002 07:43:06 -0500
Subject: Re: [ERROR]: 2.5.48 SCSI Host - No Error Handling (ide-scsi)?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200211182355.55902.spstarr@sh0n.net>
References: <200211182355.55902.spstarr@sh0n.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Nov 2002 13:18:06 +0000
Message-Id: <1037711886.11708.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-19 at 04:55, Shawn Starr wrote:
> I'm using IDE-SCSI emulation for the CRW2100E. I assume this is normal behaviour if the ide-scsi driver 
> has no error handling ;-)

Its on the list to look into more deeply. Its very unclear how to handle
the ide-scsi cases (the old code basically took an approach of 'wait
longer'). Because the bus itself is shared we have to ensure that
ide-scsi never lets a command get into the state the scsi layer thinks
it has been issued before it actually goes out on the wire (or
alternatively ensure we never reset due to timeouts from the command
which isnt currently on the bus). 

Its on the IDE job list but not that critical. 2.4 crosses its fingers
and prays, 2.5 now spots such devices and bitches about them 8)

