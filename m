Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261538AbSJNLRe>; Mon, 14 Oct 2002 07:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261500AbSJNLRe>; Mon, 14 Oct 2002 07:17:34 -0400
Received: from babyruth.hotpop.com ([204.57.55.14]:53451 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP
	id <S261378AbSJNLRc>; Mon, 14 Oct 2002 07:17:32 -0400
From: "immortal1015" <immortal1015@hotpop.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: question about ioctl and kiobuf interface
X-mailer: Foxmail 4.2 [cn]
Date: Mon, 14 Oct 2002 19:29:50 +0800
Message-Id: <20021014112303.65D7C2F8104@smtp-1.hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all. The question is somewhat out of the topics here.
I am trying to use kiobuf interface in my module.
In module, I use create_proc_entry(PROC_FILE_NAME, 0,  NULL) to create an entry 
named "/proc/test". In my application, first open the file "/proc/test" to get a handle,
and then use malloc to allocate some memory, then use ioctl method to  pass the memory address to my module. The codes as following:
/////////////////////////////////////////////////
//application codes:
int main()
{
	int file_desc, ret_val;
	unsigned char   *buf;
	file_desc = open(DEVICE_FILE_NAME, O_RDONLY);	
	buf = (unsigned char *)malloc(TEST_SIZE);
	printf("malloc: %d\n", buf);
	ioctl(file_desc, SM_IOC_SHAREMEM, buf);
	printf(buf);
	printf("\r\n");
    close(file_desc);
    free(buf);
  	printf("Goodbye\n");
    exit(0);
}
/////////////////////////////////////////
The ioctl interface provided by my module is as following:

int   sm_ioctl(struct inode *inode, struct file *filp,
                 unsigned int cmd, unsigned long arg)
{
	int   ret;
	switch(cmd)
	{
		case  SM_IOC_SHAREMEM:
			{
				printk("<1>buf address is %d\n", (unsigned char *)arg);
				sm_test_kiobuf(arg);
				ret = SUCCESS;
			}
			break;
		default:
			ret = SUCCESS;
			break;
	}
	return ret;
}

void   sm_test_kiobuf(unsigned long  userbuf)
{
	//KernelBuff is a global viriable defined as
	//unsigned char KernelBuff[12];
	memcpy((unsigned char   *)userbuf, KernelBuff, 12);
}

///////////////////////////////////////////////////////////////////////////////

The module and the application work fine. That means I can manipulate user space buffer
directory in my module's ioctl interface. And then why use KIOBUF interfaces?

What is wrong with my concepts?
Please give me advices.

Thanks




