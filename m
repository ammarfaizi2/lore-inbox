Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbTCIWfQ>; Sun, 9 Mar 2003 17:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262654AbTCIWfQ>; Sun, 9 Mar 2003 17:35:16 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:9613 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S262653AbTCIWfP>;
	Sun, 9 Mar 2003 17:35:15 -0500
Date: Sun, 9 Mar 2003 23:45:52 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Fwd: struct inode size reduction.
Message-ID: <20030309224552.GA3047@werewolf.able.es>
References: <20030309135402.GB32107@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030309135402.GB32107@suse.de>; from davej@codemonkey.org.uk on Sun, Mar 09, 2003 at 14:54:03 +0100
X-Mailer: Balsa 2.0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.09, Dave Jones wrote:
> Third retry, perhaps it'll make it through to the list
> now that vger is sending mail again...
> 

If you do not need gcc-2.95 support, you can use anonymous unions:

+	union {
+		struct pipe_inode_info	*i_pipe;
+		struct block_device	*i_bdev;
+		struct char_device	*i_cdev;
+	};

so you don't even have to change the accesses. Zero cost optimization patch.

I have tested on gcc-3.0, 3.2.2, RH gcc-2.96-98, and 2.95.2. Only 2.95.2
fails.

I do not know the compiler requirements for 2.5, or if there is any agreement
in kernel developement for not doing this. If this is the case, sorry for
the noise.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre5-jam0 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
