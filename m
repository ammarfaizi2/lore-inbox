Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289874AbSA2UpN>; Tue, 29 Jan 2002 15:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289880AbSA2UpF>; Tue, 29 Jan 2002 15:45:05 -0500
Received: from dsl-213-023-043-145.arcor-ip.net ([213.23.43.145]:48263 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289874AbSA2Uov>;
	Tue, 29 Jan 2002 15:44:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, Oliver Xymoron <oxymoron@waste.org>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Tue, 29 Jan 2002 21:48:55 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
In-Reply-To: <Pine.LNX.4.33L.0201291524570.12225-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0201291524570.12225-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VfBX-0000AN-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 06:25 pm, Rik van Riel wrote:
> On Tue, 29 Jan 2002, Oliver Xymoron wrote:
> 
> > Daniel's approach seems to be workable (once he's spelled out all the
> > details) but it misses the big performance win for fork/exec, which is
> > surely the common case. Given that exec will be throwing away all these
> > mappings, we can safely assume that we will not be inheriting many shared
> > mappings from parents of parents so Daniel's approach also still ends up
> > marking most of the pages RO still.
> 
> It gets worse.  His approach also needs to adjust the reference
> counts on all pages (and swap pages).

Well, Rik, time to present your algorithm.  I assume it won't reference 
counts on pages, and will do some kind of traversal of the mm tree.  Note 
however, that I did investigate the class of algorithm you are interested in, 
and found only nasty, complex solutions there, with challenging locking 
problems.  (I also looked at a number of possible improvements to virtual 
scanning, as you know, and likewise only found ugly or inadequate solutions.)

Before you sink a lot of time into it though, you might add up the actual 
overhead you're worried about above, and see if it moves the needle in a real 
system.

-- 
Daniel
