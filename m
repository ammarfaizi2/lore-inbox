Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267096AbSKXAmb>; Sat, 23 Nov 2002 19:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267110AbSKXAma>; Sat, 23 Nov 2002 19:42:30 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:24582 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S267096AbSKXAma>;
	Sat, 23 Nov 2002 19:42:30 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: New module loader makes kernel debugging much harder 
In-reply-to: Your message of "Sat, 23 Nov 2002 16:23:46 -0000."
             <20021123162346.GB30167@compsoc.man.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 24 Nov 2002 11:49:32 +1100
Message-ID: <25340.1038098972@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2002 16:23:46 +0000, 
John Levon <levon@movementarian.org> wrote:
>On Sat, Nov 23, 2002 at 01:43:20PM +1100, Keith Owens wrote:
>
>> Only if you assume that the .text is at a known offset from the start
>> of the module.  There are multiple programs that need to know where
>> each section really is, instead of making assumptions about how a
>> module is laid out.
>
>Yes, sorry, that is what I meant.

Even for module profiling, we need section data available.

Although all module code currently goes in a single text area, there is
no guarantee that will always be the case.  In the past we have had
multiple text areas in modules (out of line lock code used its own
section for a long time) and future changes could require multiple text
sections.  To do profiling correctly, you need to know where all the
text sections are, i.e. the module loader has to publish symbols and
section data.  Loosing that data is a big step backwards.

