Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291104AbSBSKko>; Tue, 19 Feb 2002 05:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291106AbSBSKke>; Tue, 19 Feb 2002 05:40:34 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.93]:27396 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id <S291104AbSBSKkZ>; Tue, 19 Feb 2002 05:40:25 -0500
Date: Tue, 19 Feb 2002 10:40:16 +0000
From: Bob Dunlop <bob.dunlop@xyzzy.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davem@redhat.com, kuznet@ms2.inr.ac.ru, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: Moving fasync_struct into struct file?
Message-ID: <20020219104016.A16542@xyzzy.org.uk>
In-Reply-To: <E16d4XU-0003VI-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16d4XU-0003VI-00@wagner.rustcorp.com.au>; from rusty@rustcorp.com.au on Tue, Feb 19, 2002 at 08:00:31AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 19,  Rusty Russell wrote:
> 	This means we need a move the "struct fasync_struct
> fasync_list" into struct file (up from all the subsystems which use
> it, eg. struct socket).
> 
> See any problems with this?

At first I thought I would clean up the drivers a little moving common
code from the release routine.  The release code is not called in the
example you gave because of the fork, correct ?

Then I realised what happens if several processes all request SIGIO
notification on different descriptors.  The driver still needs to keep
a private list of all the processes registered with it.  struct file
should at best contain a pointer back to the relevant structure in the
driver private list for cleanup ?
-- 
        Bob Dunlop
