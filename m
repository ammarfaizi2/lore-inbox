Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276695AbRJBVTy>; Tue, 2 Oct 2001 17:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276693AbRJBVTo>; Tue, 2 Oct 2001 17:19:44 -0400
Received: from embolism.psychosis.com ([216.242.103.100]:13324 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S276695AbRJBVTg>; Tue, 2 Oct 2001 17:19:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: "Pascal" <pascal@claude-bernard.net>
Subject: Re: [LRP] initrd-dyn for 2.4.10 kernel ?
Date: Tue, 2 Oct 2001 17:21:41 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20011002185803.19697.qmail@claude-bernard.net>
In-Reply-To: <20011002185803.19697.qmail@claude-bernard.net>
Cc: LRP <linux-router@linuxrouter.org>,
        LRPD <linux-router-devel@linuxrouter.org>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15oWww-0006rw-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 October 2001 14:58, you wrote:
> I understand that substantial changes were made in 2.4.10 initrd and init .
> Therefore the 2.4.9  initrd-dyn patch does not work on a 2.4.10 kernel. Has
> any one worked that out ?
> Pascal

Ain't it a bitch the next kernel released breaks this patch? (Note the patch 
has been good since 2.4.2 and the code base supports 2.0 and 2.2 as well)

I took a look at it and I'm not sure what the problem is, but I'm pretty 
confident it's a bug in the Linux changes and not Initrd Dynamic.

When the initrd_dyn code calls 
	infile.f_op->release(inode, &infile);
the kernel reports "Freeing initrd memory: " then panics.

This code closes the initrd memory space 'file'. This is at the END
of the initrd_dyn, after all mkfs and untar has been done successfully.
WTF this would cause a panic, I have no clue except that somebody has been
playing around much too much with the init and intird memory handling.

Other people have been complaining of problems with invalidatebuffers
which is most likely related to this problem. I'm hopeful an 'ac' or 'pre' 
kernel will fix this soon. (Anyone willing to try them, send me feedback.)

In any event 2.4.10 appears to be a pretty screwed up kernel, with 2.4.9 not 
too far behind. I recommend people stick with 2.4.8. Unfortunatly .10
has many reiserfs improvments and can handle several nice new iptables 
features. (Via patch o matic) : <

Dave

-- 
The time is now 22:19 (Totalitarian)  -  http://www.ccops.org/clock.html
