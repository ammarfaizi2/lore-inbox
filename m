Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266742AbUFYOWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266742AbUFYOWy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 10:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266743AbUFYOWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 10:22:54 -0400
Received: from sarajevo.idealx.com ([213.41.87.90]:38785 "EHLO
	sarajevo.idealx.com") by vger.kernel.org with ESMTP id S266742AbUFYOWv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 10:22:51 -0400
From: =?iso-8859-1?q?S=E9bastien_BOMBAL?= <sbombal@idealx.com>
Organization: IDEALX
To: linux-kernel@vger.kernel.org
Subject: [Question] kernel 2.6.3 writring on device ?
Date: Fri, 25 Jun 2004 16:22:17 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406251622.17395.sbombal@idealx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a little problem with a module.

I am trying to write a cryptoloop like. It is working, and I crypt the I/O.

Then I had a IOCTL in order to store the algorythm and cipher used in the 
beginning of the backend device to a fixed offset. 

I get from the user land a file descriptor, and I get the file structure from 
fget().

tmcrypt represents a structure of the device which crypts, and 
cryptonit_backing_file is the file structure for the backend device.

The problem is : the kernel freeze jut after the end of the IOCTL. (from the 
log..). But If I comment the line of the write operation, everythning is 
normal. Any ideas ?

Thanks for your help.

Regards.


/** FIXME  **/

  tmpcrypt->cryptonit_backend_file->f_pos = 0;

  if(IS_RDONLY(tmpcrypt->cryptonit_backend_file->f_dentry->d_inode) 
     || (NULL == tmpcrypt->cryptonit_backend_file->f_op->write)){
    err = -EACCES;
    printk (KERN_ERR "cryptonit : Inode is readonly ?\n");
    goto out_free_tfm;
  }

  printk(KERN_DEBUG "cryptonit : not readonly\n");

  err = get_write_access(tmpcrypt->cryptonit_backend_file->f_dentry->d_inode);
  if (err){
    printk (KERN_ERR "cryptonit : cryptonit cannot get_write_access\n");
    goto out_free_tfm;
  }	

  printk(KERN_DEBUG "cryptonit : down semaphore backing file\n");  
  down(&tmpcrypt->cryptonit_backend_file->f_mapping->host->i_sem);
 
  err = 
tmpcrypt->cryptonit_backend_file->f_op->write(tmpcrypt->cryptonit_backend_file, 
						      "test", 4,
						      &tmpcrypt->cryptonit_backend_file->f_pos);
  
  printk(KERN_DEBUG "cryptonit : up semaphore backing file\n");  
  up(&tmpcrypt->cryptonit_backend_file->f_mapping->host->i_sem);
  
/******** END *********/

-- 
Sébastien BOMBAL - IDEALX
Ingénieur Développeur
EPITA - SRS.
