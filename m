Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751732AbWCUOoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbWCUOoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbWCUOoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:44:12 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:36 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751729AbWCUOoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:44:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=uWvB+xa75ZaC/xbQa/wSJEYEHySFxCxU0ZIGFtMdO4/t51+HViTih9Cd+bVPOaKj+Pq6MCJjuCRqtmjtpXoVw7WOXBmc9TI6HnMnBAxr96mlcxysk8MbjTxSESpDP8SXRHh4IiBreMGdVtmzly8FyRXxHtiVtRrHqMw5PUT3OxY=
Message-ID: <b681c62b0603210644p41711a16ydda5b18bfb531641@mail.gmail.com>
Date: Tue, 21 Mar 2006 20:14:08 +0530
From: "yogeshwar sonawane" <yogyas@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: referring a user address from ioctl entry point
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6023_23810954.1142952248928"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_6023_23810954.1142952248928
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

can we write directly to user virtual address from kernel space?
i.e. dereferencing a user address from driver entry point?

I am attaching my sample driver code with user application.

I tried to run this on RHEL4-U2. it is running fine.

But on FC3, its not working giving segmentation fault in user space.
The kernel messeges are:-

Mydevice: open
Mydevice: ioctl: GET_SIZE<1>Unable to handle kernel paging request at
virtual address fefd53a0
 printing eip:
1282319d
*pde =3D 00000000
Oops: 0002 [#1]
Modules linked in: driver1(U) parport_pc lp parport autofs4 i2c_dev
i2c_core sunrpc md5 ipv6 dm_mod uhci_hcd snd_cs46xx snd_rawmidi
snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm
snd_timer snd soundcore snd_page_alloc gameport 3c59x floppy ext3 jbd
aic7xxx sd_mod scsi_mod
CPU:    0
EIP:    0060:[<1282319d>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-1.667)
EIP is at my_ioctl+0x67/0x72 [driver1]
eax: 0000001a   ebx: fefd53a0   ecx: 128232aa   edx: 090e2f90
esi: 80047a03   edi: 0a17bca0   ebp: ffffffe7   esp: 090e2f8c
ds: 007b   es: 007b   ss: 0068
Process a.out (pid: 3027, threadinfo=3D090e2000 task=3D0916d770)
Stack: 128232aa 12823960 0217a147 fefd53a0 0881c2e4 0a17bca0 00000003 090e2=
fc0
       00000004 090e2fc4 fefd5434 fefd53c0 090e2000 ffff4200 00000003 80047=
a03
       fefd53a0 fefd5434 fefd53c0 fefd53a8 00000036 0000007b 0000007b 00000=
036
Call Trace:
 [<0217a147>] sys_ioctl+0x296/0x337
Code: <3>Debug: sleeping function called from invalid context at
include/linux/rwsem.h:43
in_atomic():0[expected: 0], irqs_disabled():1
 [<0211c8b9>] __might_sleep+0x7d/0x88
 [<0215e27e>] rw_vm+0x216/0x482
 [<12823172>] my_ioctl+0x3c/0x72 [driver1]
 [<12823172>] my_ioctl+0x3c/0x72 [driver1]
 [<0215e9d0>] get_user_size+0x30/0x57
[<12823172>] my_ioctl+0x3c/0x72 [driver1]
 [<0210682b>] show_registers+0x109/0x15e
 [<02106a2f>] die+0x14a/0x241
 [<0211937e>] do_page_fault+0x0/0x511
 [<0211937e>] do_page_fault+0x0/0x511
 [<02119733>] do_page_fault+0x3b5/0x511
 [<1282319d>] my_ioctl+0x67/0x72 [driver1]
 [<02153c78>] handle_mm_fault+0xe4/0x21e
 [<0211953a>] do_page_fault+0x1bc/0x511
 [<0222b4fe>] vt_console_print+0x64/0x2a3
 [<0222b4fe>] vt_console_print+0x64/0x2a3
 [<0222b49a>] vt_console_print+0x0/0x2a3
 [<0211937e>] do_page_fault+0x0/0x511
 [<1282319d>] my_ioctl+0x67/0x72 [driver1]
 [<0217a147>] sys_ioctl+0x296/0x337
 Bad EIP value.


help me out.
thanks in advance.

------=_Part_6023_23810954.1142952248928
Content-Type: text/x-csrc; name=driver1.c; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_el2c92kz
Content-Disposition: attachment; filename="driver1.c"

#include<linux/module.h>
#include<linux/kernel.h>
#include<linux/fs.h>
#include<linux/init.h>
#include<asm/uaccess.h>

#define MAGIC 'z'
#define GET_DATA _IOR(MAGIC, 1, int *)
#define SET_DATA _IOW(MAGIC, 2, int *)
#define GET_SIZE _IOR(MAGIC, 3, int *)

struct file_operations fops;
static char array[80] = "HelloWorld";
static int major;

int Mydevice_init_module(void)
{
	printk("In init module");
	major = register_chrdev(0,"Mydevice",&fops);
	printk("\nThe device is registered by Major no: %d",major);
	if(major == -1)
		printk("\nError in registering the module");
	else
		printk("\n");
	return 0;
}


void Mydevice_cleanup_module(void)
{
	unregister_chrdev(major,"Mydevice");
	printk("In cleanup module");
}


static int my_open(struct inode *inode, struct file *file)
{
	printk("\nMydevice: open");
	return 0;
}


static int my_release(struct inode *inode, struct file *file)
{
	printk("\nMydevide: release");
	return 0;
}

static ssize_t my_read(struct file *file, char *buff, size_t n,loff_t *offset)
{
	int position = (long)*offset;
	printk("\nMydevice: read");
	copy_to_user(buff,array+position,n);
	return 0;
}


static ssize_t my_write(struct file *file, const char *buff, size_t n, loff_t *offset)
{
	int position = (long)*offset;
	printk("\nMydevice: write");
	copy_from_user(array+position,buff,n);
	return 0;	
}

static loff_t my_lseek(struct file *file,loff_t offset,int whence)
{
	printk("\nMydevice: lseek");
	switch(whence)
	{
		case 0: file->f_pos = offset;      //SEEK_SET
			break;
		case 1: file->f_pos = (file->f_pos) + offset;  //SEEK_CUR
			break;
		case 2: file->f_pos = sizeof(array) - offset;  //SEEK_END
			break;
	}
	return file->f_pos;
}


static int my_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
{
	switch(cmd)
	{
		case GET_DATA:
			printk("\nMydevice: ioctl: GET_DATA");
			copy_to_user((char *)arg, array, 80);
			break;
		case SET_DATA:
			printk("\nMydevice: ioctl: SET_DATA");
			copy_from_user(array, (char *)arg, 80);
			break;
		case GET_SIZE:
			printk("\nMydevice: ioctl: GET_SIZE");
			*(int *) arg = sizeof(array);
			break;			
	}
	return 0;
}


struct file_operations fops =  
{
	open: my_open,
	release: my_release,
	read: my_read,
	write: my_write,
	llseek: my_lseek,
	ioctl: my_ioctl,
};


module_init(Mydevice_init_module);
module_exit(Mydevice_cleanup_module);
MODULE_LICENSE("GPL");



------=_Part_6023_23810954.1142952248928
Content-Type: text/x-csrc; name=user2.c; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_el2c9b5v
Content-Disposition: attachment; filename="user2.c"

#include<stdio.h>
#include<fcntl.h>
#include<unistd.h>
#include<string.h>
#include<sys/ioctl.h>
#include"myioctl.h"

int main(void)
{
	int fd,size;
	
	int result;

	fd = open("mydevice",O_RDWR);
	if(fd == -1)
	{
		printf("\nError in open");
		return -1;
	}

	result = ioctl(fd, GET_SIZE, &size);
	if(result == -1)
	{
	        printf("\nError in ioctl");
		return -1;
	}
	printf("\nThe result of GET_SIZE: %d",size);
		
	printf("\n");	
}




------=_Part_6023_23810954.1142952248928
Content-Type: text/x-chdr; name=myioctl.h; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_el2c9ipn
Content-Disposition: attachment; filename="myioctl.h"

#define MAGIC 'z'
#define GET_DATA _IOR(MAGIC, 1, int *)
#define SET_DATA _IOW(MAGIC, 2, int *)
#define GET_SIZE _IOR(MAGIC, 3, int *)


------=_Part_6023_23810954.1142952248928
Content-Type: application/octet-stream; name=Makefile
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_el2c9nj7
Content-Disposition: attachment; filename="Makefile"

obj-m := driver1.o
KDIR := /lib/modules/$(shell uname -r)/build
#KDIR := /usr/src/redhat/BUILD/kernel-2.6.9/linux-2.6.9
PWD := $(shell pwd)

default :
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules 

clean :
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean


------=_Part_6023_23810954.1142952248928--
