Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267123AbSKXBLp>; Sat, 23 Nov 2002 20:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267124AbSKXBLp>; Sat, 23 Nov 2002 20:11:45 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:28422 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S267123AbSKXBLo>;
	Sat, 23 Nov 2002 20:11:44 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: New module loader makes kernel debugging much harder 
In-reply-to: Your message of "Sun, 24 Nov 2002 01:06:17 -0000."
             <20021124010617.GA58002@compsoc.man.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 24 Nov 2002 12:18:46 +1100
Message-ID: <25797.1038100726@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2002 01:06:17 +0000, 
John Levon <levon@movementarian.org> wrote:
>On Sun, Nov 24, 2002 at 11:49:32AM +1100, Keith Owens wrote:
>> Although all module code currently goes in a single text area, there is
>> no guarantee that will always be the case.  In the past we have had
>> multiple text areas in modules (out of line lock code used its own
>> section for a long time) and future changes could require multiple text
>> sections.  To do profiling correctly, you need to know where all the
>> text sections are, i.e. the module loader has to publish symbols and
>> section data.  Loosing that data is a big step backwards.
>
>Actually all *I* need is the address of one of the sections, as long as
>they're simply mapped in we can work backwards given the sample file
         ^^^^^^^^^^^^^
>and the offset of that section. So this already worked for when the
>locking code was a separate section. But yeah, it would be helpful for
>other uses to have more info available.

How do you know if the sections are "simply mapped"?  The module loader
could assign different sections to different mappings, there is no
guarantee that they are contiguous.  They were contiguous using the 2.4
module loader but only because the syscall only allowed for a single
area.  The new loader can assign sections anywhere it likes.

One possibility the new loader opens up is the ability to replicate the
pure module data (rodata and text) for each node of a NUMA box.  There
is already an option to replicate the kernel text on each node to cut
down inter-node traffic.  Replicating the pure module data would be
nice as well.  I guarantee that will result in something that is not
"simply mapped".

