Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSLYRLA>; Wed, 25 Dec 2002 12:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbSLYRLA>; Wed, 25 Dec 2002 12:11:00 -0500
Received: from f89.sea2.hotmail.com ([207.68.165.89]:39440 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262210AbSLYRK7>;
	Wed, 25 Dec 2002 12:10:59 -0500
X-Originating-IP: [130.54.29.179]
From: "hua xu" <xuhua18@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problem: do_ioctl() doesn't work well on setting txpower
Date: Wed, 25 Dec 2002 17:11:36 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp; format=flowed
Message-ID: <F89pcnvy3JdZZzxTS2U0001dbed@hotmail.com>
X-OriginalArrivalTime: 25 Dec 2002 17:11:37.0114 (UTC) FILETIME=[AED50FA0:01C2AC38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

       I have a problem on setting txpower in the kernel module, and I wish 
to be personally CC'ed the answers/comments posted to the list in response. 

       It is the first time for me to make a kernel module in order to 
manage txpower.I am using Vine Linux 2.4.18-0v13 and wireless LAN card is 
CISCO AIRONET 350 whose txpower can be change in 3 levels.  Following is my 
problem in the kernel programming.
	With CISCO LAN card, I can change the txpower by the command: iwconfig, 
however, in my kernel programming, I am using do_ioctl() intending to set 
txpower. There are two aspects on my problem. One aspect is that when I set 
wrq.u.txpower.value which I am intended to change, and do the do_ioctl(). 
After complying the kernel module, the wireless LAN card just turned off 
its txpower but the value is not changed. Then when I set 
wrq.u.txpower.diabled trying to keep txpower on, I got the error message (I 
am using $BEF(Brrno$BG(Band the result is $BK(B2). On the other hand, in my 
programming, I can set bitrate without any problem and can also get the 
txpower and bitrate information using do_ioctl(). I have tried to set 
wrq.u.data.pointer, wrq.u.data.length, and wrq.u.data.flags and used 
different values for the setting of txpower parameters, but they seemed no 
effect. 
         Is there any clue for solving my problem ? I would very appreciate 
for any help.
 	Following is the parts of my programming:

int set_txpower()
{
    int errno;
    mm_segment_t oldfs;
    struct interface_list_entry *dest_interface;
    struct net_device *dev;
    struct iwreq		wrq;

      strncpy(wrq.ifr_name,dest_interface->dev->name,IFNAMSIZ);       
      
	//the part of setting  the tx power		
			wrq.u.txpower.value= 1;           
                            wrq.u.txpower.disabled=0;
	                oldfs = get_fs();                         
                         set_fs(KERNEL_DS);
                         
errno=dest_interface->dev->do_ioctl(dest_interface->dev, (struct ifreq * ) 
&wrq,SIOCSIWTXPOW);
                         set_fs(oldfs);
                         if(errno<0)
                        { printk( "Error with SIOCSIWTXPOW\n");
			  printk("ERRNO: %d \n",errno);
                           }
                       else
   			printk("setting is OK\n\n");

      //the part of setting bitrate and it works without any problem//
	wrq.u.bitrate.value= 1;                   	
	 oldfs = get_fs();                      
         set_fs(KERNEL_DS);
         errno=dest_interface->dev->do_ioctl(dest_interface->dev, (struct 
ifreq * ) &wrq,SIOCSIWRATE);
         set_fs(oldfs);
}


_________________________________________________________________
$B2q0wEPO?$OL5NA(B  $B=<<B$7$?=PIJ%"%$%F%`$J$i(B MSN $B%*!<%/%7%g%s(B  
http://auction.msn.co.jp/ 

