Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282945AbSAGRZ5>; Mon, 7 Jan 2002 12:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282978AbSAGRZs>; Mon, 7 Jan 2002 12:25:48 -0500
Received: from pc4-redb4-0-cust129.bre.cable.ntl.com ([213.107.130.129]:1527
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S282945AbSAGRZb>; Mon, 7 Jan 2002 12:25:31 -0500
Date: Mon, 7 Jan 2002 17:25:28 +0000
From: Mark Zealey <mark@zealos.org>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
Message-ID: <20020107172528.GA5593@itsolve.co.uk>
In-Reply-To: <5.1.0.14.2.20020107134718.025e4d90@pop.cus.cam.ac.uk> <5.1.0.14.2.20020107134718.025e4d90@pop.cus.cam.ac.uk> <5.1.0.14.2.20020107155722.02e87820@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020107155722.02e87820@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux sunbeam 2.4.17-wli1 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 04:01:33PM +0000, Anton Altaparmakov wrote:

> >> >         at this point we have what Linus described:
> >> >
> >> >                 struct ext2_inode_info {
> >> >                         ...ext2 stuff...
> >> >                         struct inode inode;
> >> >                 };
> >
> >Interesting, it's something I've always wanted to be able to do.  But I
> >suppose the compiler requirement is a stupport.
> 
> Yes. I wonder if gcc people can be persuaded to backport annonymous 
> structures and unions into gcc-2.95...?

You can fake it in a semi-messy way, using a #define, like:

#define STRUCT_INODE				\
	struct list_head        i_hash;		\
	struct list_head        i_list;		\
	struct list_head        i_dentry;	\
	...

struct inode {
	STRUCT_INODE;
};

struct ext2_inode_info {
	...ext2 stuff...
	STRUCT_INODE;
};


-- 

Mark Zealey
mark@zealos.org
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)
