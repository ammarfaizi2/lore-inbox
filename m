Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312457AbSEQFn5>; Fri, 17 May 2002 01:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312486AbSEQFn4>; Fri, 17 May 2002 01:43:56 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56324
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312457AbSEQFnz>; Fri, 17 May 2002 01:43:55 -0400
Date: Thu, 16 May 2002 22:43:32 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Justin Piszcz <war@starband.net>, linux-kernel@vger.kernel.org
Subject: Re: sg in 2.4.18
In-Reply-To: <20020517044650.GC627@matchmail.com>
Message-ID: <Pine.LNX.4.10.10205162234270.774-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002, Mike Fedyk wrote:

> On Mon, May 13, 2002 at 11:41:30AM -0400, Justin Piszcz wrote:
> > Also, putting both burners on the same chain currently does not work.
> > Because when cdrecord sends the command to FIX the cd after it is done
> > burning the data, the command gets sent to both IDE drives causing cdrecord
> > to blow up (the burn fails) on the other burner.
> 
> Hmm, I wonder in Andre can say anyting about this.

The short answer is the driver currently does not support proper overlap
and release of the bus (channel/hwif).  Until this is committed to code to
support a multi-threaded request to schedule on service priorities, it is
not doable.  Burn-Proof will greatly assist in a solution, as a means to
force the device to spin while doing dual burns.  Thus some means for a
channel/hwif merging queue is needed.  I have a partial whiteboard
solution but it is incomplete.

> What kernel version are you running?
> 
> Can you post the output of lspci?
> 
> With both drives running at the same time, each on a seperate cable and
> controller, I was able to write without trouble.
> 
> 00:00.0 Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 02)
> 00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
> 00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
> 00:07.2 USB Controller: Intel Corp. 82371SB PIIX3 USB [Natoma/Triton II]
> (rev 01)
> 00:08.0 VGA compatible controller: Trident Microsystems TGUI 9660/968x/968x
> (rev d3)
> 00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20262 (rev
> 01)
> 00:0a.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 02)
> 00:0b.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
> 

Andre Hedrick
LAD Storage Consulting Group

