Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbTGGKwL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 06:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbTGGKwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 06:52:11 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:45248 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S264887AbTGGKwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 06:52:07 -0400
Date: Mon, 7 Jul 2003 13:08:58 +0200
From: Vincent Touquet <vincent.touquet@pandora.be>
To: joe briggs <jbriggs@briggsmedia.com>
Cc: Andrew Morton <akpm@osdl.org>, vincent.touquet@pandora.be,
       linux-kernel@vger.kernel.org
Subject: Re: [Bug report] System lockups on Tyan S2469 and lots of io [smp boot time problems too :(]
Message-ID: <20030707110858.GB7233@ns.mine.dnsalias.org>
Reply-To: vincent.touquet@pandora.be
References: <20030706210243.GA25645@lea.ulyssis.org> <20030707005449.GF4675@ns.mine.dnsalias.org> <20030706191941.33f9e37a.akpm@osdl.org> <200307070743.27084.jbriggs@briggsmedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307070743.27084.jbriggs@briggsmedia.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 07, 2003 at 07:43:27AM -0400, joe briggs wrote:
>I was pulling my hair out (whats left of it) last week trying to get a Tyan 
>2466 dual AMD 2800 MP (512 MB REGISTERED DDR, 3ware 7000-2 w/2 WD2000 drives 
>and a WD800 IDE system drive, 2.4.21 Debian, ReiserFS) to run reliably under 
>heavy disk and i/o (16 frame grabbers running a surveillance application).  
>Eventually I would get "hda: missed interrupt .." and soon after ReiserFS 
>file corruption.  I suspected memory and tried unbuffered DDR, and 4 
>manufacturers of buffered DDR, all with the same results.  So I took pulled 
>out the system drive, 3ware controllers and data drives, and frame grabbers 
>and put them on a Intel P4/Intel motherboard, and everything booted and 
>worked like a charm (though with more CPU load).  So I am wondering now if 
>this file system corruption under heavy i/o load has something to do with SMP 
>code?

Hi Joe :)

I'm still pulling my hair out here too ;)

I don't think smp is to blame, as I have lockups with UP too ...
I think there is something badly wrong at a low level when running any
2.4.x kernel on a Tyan mainboard, which shows up at high IO.

Where you using any IDE related stuff on your Tyan ?
Did you enable highmem ?

I just finished compiling 2.4.21 here with magic sysreq support, I hope
to get some useful data after the lockup.
After the array has been rebuilt though (sigh).

So far I see two different issues, possibly related:

- smp kernel does not boot unless given acpi=off
  Without this command line option there is an _endless_ resetting of the
  3Ware card at boot time
- lockup when copying large amount of data from disk (ide) to array
  (scsi), on the console it says that there is a time-out on a 3Ware
  command and the card needs to be reset
  The same problem was shown with a copy over the network onto the array
  (so not touching ide, except probably for swap).

There is definitely an issue with the mainboard and the kernel here.
I swapped everything (psu, 3Ware card, disks, mainboard !), to no avail.

Any help would be much appreciated.

There should be people running Linux on these boards ?

regards,

Vincent

PS: a possibility is too that the board needs ACPI built into the kernel
in order to work ?
PPS: I own a Tyan S2468 too in my webserver, though the IO there is much
more modest (no 3Ware card either), so far no problems there (knock on
wood)
