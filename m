Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288657AbSADOt0>; Fri, 4 Jan 2002 09:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288656AbSADOtI>; Fri, 4 Jan 2002 09:49:08 -0500
Received: from jalon.able.es ([212.97.163.2]:30639 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S288655AbSADOs4>;
	Fri, 4 Jan 2002 09:48:56 -0500
Date: Fri, 4 Jan 2002 15:52:17 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Message-ID: <20020104155217.A3864@werewolf.able.es>
In-Reply-To: <200201031605.g03G57e22947@guppy.limebrokerage.com> <E16MBIw-00018y-00@starship.berlin> <20020104002553.A15792@werewolf.able.es> <E16MJPZ-0001AQ-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E16MJPZ-0001AQ-00@starship.berlin>; from phillips@bonn-fries.net on Fri, Jan 04, 2002 at 02:44:39 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020104 Daniel Phillips wrote:
>
>Needing to type 'struct' everywhere is annoying and makes for long lines.
>Other than that it's harmless, and actually, the situation where you have two 
>ways of spelling everything is annoying too.  Anyway, if it was to be done,
>I'd spell it:
>
>	typedef struct super_struct super;
>	typedef struct inode_struct inode;
>
>	static inline inode *new_inode(super *sb)
>	{
>		inode *ni = (inode *) malloc(sizeof(inode));
>		...
>	}
>
>It won't happen though, because it would generate a massive diff for the sole 
>reason of making things prettier, and a very high percentage of existing 
>patches would break immediately.  If you're going to clean stuff up, you have 
>to do it a bit at a time while you're working on other things.
>

>From my point of view, this kind of changes can keep compatability and be done
in small chunks if you do something like

typedef struct inode inode_t;
typedef struct super_block super_block_t;

so old code still builds, new code can use new types and you can patch
code smoothly. And you can grep-r for both usages in the tree.

But all is a matter of preferences. I found it cleaner. Some people
hate the _t suffix. Many people prefer explicit 'struct' than opaque
types. And so on...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre1-beo #1 SMP Fri Jan 4 02:25:59 CET 2002 i686
