Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312643AbSCVDBP>; Thu, 21 Mar 2002 22:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312644AbSCVDBF>; Thu, 21 Mar 2002 22:01:05 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:41745 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S312643AbSCVDAu>;
	Thu, 21 Mar 2002 22:00:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15514.40289.569648.109200@gargle.gargle.HOWL>
Date: Fri, 22 Mar 2002 13:56:33 +1100
From: Christopher Yeoh <cyeoh@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        torvalds@transmeta.com (Linus Torvalds),
        marcelo@conectiva.com.br (Marcelo Tosatti)
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] fcntl returns wrong error code (Updated)
In-Reply-To: <15513.59145.678790.431319@gargle.gargle.HOWL>
X-Mailer: VM 7.03 under Emacs 21.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2002/3/22 00:58+1100  Christopher Yeoh writes:
> btw Stephen Rothwell pointed out that there is a much neater way to
> achieve the same change. I'll post a new patch in the morning.

This is the updated patch.

--- linux-2.4.18/fs/fcntl.c~	Fri Mar 22 11:54:35 2002
+++ linux-2.4.18/fs/fcntl.c	Fri Mar 22 12:31:18 2002
@@ -66,6 +66,10 @@
 
 	write_lock(&files->file_lock);
 	
+	error = -EINVAL;
+	if (orig_start >= current->rlim[RLIMIT_NOFILE].rlim_cur)
+		goto out;
+
 repeat:
 	/*
 	 * Someone might have closed fd's in the range
