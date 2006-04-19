Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWDSTCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWDSTCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWDSTCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:02:05 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:42891 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751176AbWDSTCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:02:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=R5+DX9NAl7EDkc3PB8o33j47dGdbNuQQZHs8POQVvJp/4cWF/19BqdBYx4PrN00KSUl/6w5sZGWK9aMi0MMmKrND0zdG1BGgWbrIi8MmKMAJpxOpkbqDVaW3i7FOXgMREGg2DFcE51O8yKrKsfM3YhkzGHjrXsnB0uIslmgG3+c=
Message-ID: <444688F2.5060909@gmail.com>
Date: Wed, 19 Apr 2006 12:01:06 -0700
From: Hua Zhong <hzhong@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       torvalds@osdl.org, davem@davemloft.net, akpm@osdl.org
Subject: [PATCH] sockfd_lookup_light() returns random error for -EBADFD
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This applies to 2.6.17-rc2.

There is a missing initialization of err in sockfd_lookup_light() that could return random error for an invalid file handle.

Signed-off-by: Hua Zhong <hzhong@gmail.com>

diff --git a/net/socket.c b/net/socket.c
index 23898f4..0ce12df 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -490,6 +490,7 @@ static struct socket *sockfd_lookup_ligh
 	struct file *file;
 	struct socket *sock;
 
+	*err = -EBADF;
 	file = fget_light(fd, fput_needed);
 	if (file) {
 		sock = sock_from_file(file, err);
