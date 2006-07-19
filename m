Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWGSInc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWGSInc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 04:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWGSInc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 04:43:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:4633 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932530AbWGSInc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 04:43:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:organization:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=HuKQrWrFsdGMF6ob7QwnxkW2xjzd2s65npJs/0PHvnSkxMZTGEdJs2fL8rTAr3FN7kDFEyt4ujyssI/gJcOL3zhhQH386NFmIUV3O1Fwb6R0Yr84B8fe/YB5b5xgzUY+OhKepu/3u8Ar8glv4cwMeygHdJZ4fj4hqFyYHsdBDhI=
Message-ID: <44BDF21B.60207@innomedia.soft.net>
Date: Wed, 19 Jul 2006 14:19:31 +0530
Reply-To: chinmaya@innomedia.soft.net
Organization: Innomedia Technologies Pvt. Ltd.
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: How to mount own file system in linux
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Chinmaya Mishra <chinmaya4@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
        I want to create new file system in linux 2.6.10 kernel just to 
print the super block information.
Can you suggest me where I can get some good documents to proceed or any 
dummy code if any.

I have tried this with the following code but it gives some warning 
messages during compilation. The file system is registered but during 
the mount command segmentation fault occurs.

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/version.h>
#include <linux/fs.h>
#include <linux/sched.h>

static struct super_block *rfs_read_super( struct super_block *sb, void 
*buf, int size);
static struct file_system_type rfs = {"rfs", 0, rfs_read_super, NULL};
/*--------------------------------------------------------------------------------------------*/ 

static struct super_block *rfs_read_super( struct super_block *sb, void 
*buf, int size) {
       printk("rkfs: read_super returning a valid super_block\n" );
       sb->s_blocksize = 1024;
       sb->s_blocksize_bits = 10;
       return sb;
}
/*--------------------------------------------------------------------------------------------*/ 

int init_module(void) {
       int err;
       err = register_filesystem(&rfs);
       printk("rkfs: file system registered\n" );
       return err;
}
/*--------------------------------------------------------------------------------------------*/ 

void cleanup_module(void) {
       unregister_filesystem(&rfs);
       printk("rkfs: file system unregistered\n" );
}
/*--------------------------------------------------------------------------------------------*/ 

MODULE_LICENSE("GPL");

regards,
chinmaya

