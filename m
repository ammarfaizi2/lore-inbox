Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288447AbSADBln>; Thu, 3 Jan 2002 20:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288446AbSADBle>; Thu, 3 Jan 2002 20:41:34 -0500
Received: from dsl-213-023-043-248.arcor-ip.net ([213.23.43.248]:38927 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288442AbSADBlZ>;
	Thu, 3 Jan 2002 20:41:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Date: Fri, 4 Jan 2002 02:44:39 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Ion Badulescu <ion@cs.columbia.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <200201031605.g03G57e22947@guppy.limebrokerage.com> <E16MBIw-00018y-00@starship.berlin> <20020104002553.A15792@werewolf.able.es>
In-Reply-To: <20020104002553.A15792@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16MJPZ-0001AQ-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 4, 2002 12:25 am, J.A. Magallon wrote:
> Perhaps it is a silly question for kernel hackers, but I found it useful
> for making code more readable...
> Why dont you use things like:
> 
> typedef struct inode inode;
> typedef struct super_block super_block;
> 
> so you can write things like
> 
> static inline inode* new_inode(super_block* cb)
> {
> 	inode* ni;
> 	ni = (inode*)malloc(sizeof(inode));
> 	...
> }
> 
> (ie, kill 'struct' visual pollution...)
> 
> ??
> 
> Isn't it more readable ?
> 
> Just curious...

Needing to type 'struct' everywhere is annoying and makes for long lines.
Other than that it's harmless, and actually, the situation where you have two 
ways of spelling everything is annoying too.  Anyway, if it was to be done,
I'd spell it:

	typedef struct super_struct super;
	typedef struct inode_struct inode;

	static inline inode *new_inode(super *sb)
	{
		inode *ni = (inode *) malloc(sizeof(inode));
		...
	}

It won't happen though, because it would generate a massive diff for the sole 
reason of making things prettier, and a very high percentage of existing 
patches would break immediately.  If you're going to clean stuff up, you have 
to do it a bit at a time while you're working on other things.

--
Daniel
