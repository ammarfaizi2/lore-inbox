Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131314AbQKTF1I>; Mon, 20 Nov 2000 00:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131129AbQKTF0u>; Mon, 20 Nov 2000 00:26:50 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:2579 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131326AbQKTF0p>; Mon, 20 Nov 2000 00:26:45 -0500
Date: Sun, 19 Nov 2000 22:53:05 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NCPFS not returning Volume Size (???)
Message-ID: <20001119225305.D29253@vger.timpanogas.org>
In-Reply-To: <20001116204029.A15356@vger.timpanogas.org> <20001119171006.B379@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001119171006.B379@ppc.vc.cvut.cz>; from vandrove@vc.cvut.cz on Sun, Nov 19, 2000 at 05:10:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2000 at 05:10:06PM +0100, Petr Vandrovec wrote:
> On Thu, Nov 16, 2000 at 08:40:29PM -0700, Jeff V. Merkey wrote:
> > Petr,
> > 
> > NCPFS in 2.2.18-pre21 is not returning volume size via df -h.  I checked
> > your code and found this comment:
> > 
> > static int ncp_statfs(struct super_block *sb, struct statfs *buf, int bufsiz)
> > {
> > NCP Code
> > 
> > 2222/17E6   Get Object's Remaining Disk Space
> > 
> > I noticed that 2.4 also is not reporting Volume free space.  
> 
> Yes, it is intentional. There are two different things:
> (1) you can mount all volumes from server to one mountpoint, and all these
>     volumes share one superblock. So it is not clear, which value to
>     return. Sum of all volume sizes?
> (2) in Netware, each directory can have its own space limit, so
>     returned free space should differ from directory to directory.
>     As statfs is per-superblock thing, I believe that returning
>     'sorry, I do not know' is better.
> 
> > grouped into case/switch classes.  If you can point me to 
> > where 1) the login ID is stored and B) where NCP packet 
> > request/reponse headers are constructed, i.e. a skeleton 
> > to send/receive the requests I can grab, I'll try to 
> > code this for you.
> 
> loginID is not stored anywhere in kernel. You can look at
> ioctl(,NCP_IOC_GETOBJECTNAME,...). If you need your own ID
> so you know which disk space restriction retrieve, you'll have
> to first execute retrieve logged in info for current connection
> (where connection number is stored in server->connection).
> 
> request/reply is built in preallocated space, you can look
> at functions in ncplib_kernel.c, f.e. ncp_open_create_file_or_subdir
> uses almost every of ncp_add_* functions. ncp_request() then
> executes RPC call and ncp_unlock_server() unlocks connection.
> You must NOT access userspace between ncp_init_request()
> and ncp_unlock_server() function, or deadlock can occur.
> 

There's is a method to obtain this accurately.  NSS may have 
changed some things.  I have a list of four issues now with this 
one I need to get finished.  I may need some help with your code
as I go.

Jeff


> 					Best regards,
> 						Petr Vandrovec
> 						vandrove@vc.cvut.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
