Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130156AbRBTLVP>; Tue, 20 Feb 2001 06:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130154AbRBTLVG>; Tue, 20 Feb 2001 06:21:06 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:13839 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130156AbRBTLU5>; Tue, 20 Feb 2001 06:20:57 -0500
Date: Tue, 20 Feb 2001 12:19:09 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Srinivas Surabhi <srinivas.surabhi@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: parameters passing problem in driver module
Message-ID: <20010220121909.E8042@arthur.ubicom.tudelft.nl>
In-Reply-To: <77452C3AEA9.AAA40DE@vindhya.mail.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <77452C3AEA9.AAA40DE@vindhya.mail.wipro.com>; from srinivas.surabhi@wipro.com on Tue, Feb 20, 2001 at 04:07:55PM +0530
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 04:07:55PM +0530, Srinivas Surabhi wrote:
> In application program ,code for call to write system call is given
> below...
>       #include<fcntl.h>
>     main()
> 	 { 
> 	  int count,fd;
> 	 fd=open("/dev/pseudo",O_RDWR);
> 	  write(fd,buff,5);
> 	  }
> 	  
> In driver module code for getting the buffer and count 
> 
>     #include<all related header files...>
>      
>     int psuedo_write(struct inode*in,struct file*fp,char *buf,int count)

This should read:

static ssize_t pseudo_write(struct file* file, 
                            const char *buf, 
                            size_t count,
                            loff_t* ppos);

>     {
>       kprintf("<1>pseudo_write routine called \n");
>       kprintf("<1>count=%d \n",count);
>       kprintf("<1>buffer=%s \n",buff);
>       return 0;
>     } 
> /******so here after inserting the module into the kernel using insmod 
> pseudo.o and executing the application cc -c pseudo_app.c, the o/p on
> console is *****/
> 
> "pseudo_write routine called" 
> "count=9988345352" /*garbage*/
> "buffer=@#%h" .   /*garbage*/
> 
> /*** but neither the  buffer is carried from user space to kernel space nor
> the count, why?***/Please help me
> out.

Not strange at all, you're using the wrong parameters so you get what
you asked for: garbage in, garbage out.

You get the source for all other drivers for free. Use it.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
