Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317384AbSGTNjd>; Sat, 20 Jul 2002 09:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317388AbSGTNjd>; Sat, 20 Jul 2002 09:39:33 -0400
Received: from web12903.mail.yahoo.com ([216.136.174.70]:53555 "HELO
	web12903.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317384AbSGTNjb>; Sat, 20 Jul 2002 09:39:31 -0400
Message-ID: <20020720134235.65542.qmail@web12903.mail.yahoo.com>
Date: Sat, 20 Jul 2002 14:42:35 +0100 (BST)
From: =?iso-8859-1?q?will=20fitzgerald?= <will_m_fitzgerald@yahoo.co.uk>
Subject: printk log problem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all, 

i have a printk formating question. 

in my /var/log/trace file i have kernel debug messages
being logged there. 

it is in the format of: (for example)

 jul 20 13:50 homer kernel: >2 <7> 1 <7> 2
<7>4 and so on. 

on the next line i have jul 20 13:50 homer kernel:
>3000 <7> 3500 <7> 2070 <7>2500 and so on. 

what i'm printing to this file is an an array of
buffered printk's of trace points in the
kernel that prints a functions id and its time.

 my problem is how do you get rid of the "jul 20 13:50
homer kernel:" part. i need to analysis the file later
on and using the fseek(fp,offset,SEEK_SET)
command i can bypass the first "jul 20 13:50 homer
kernel:" but not the second or third and so on.

 what i do is open the the trace file after i pump
packets trough router (linux) (which triggers
certain net funtions in which contain my function to
buffer up printk's until array is full.)

 next i want to take out all the function id's and
times from the trace file and insert them back into a
new array (in user space, which i have being doing) so
i can calculate what time each function took to work
on an inoming packet.

 i use fseek to bypass the "jul 20 13:50 homer
kernel:" and write the
remainder ">2 <7> 1 <7> 2 <7>4" to a new file. 

from here i open this new file and use :

 while ((fscanf(fpnew," %s %d",c,&d))!=EOF){

 b[i]=d; // stores the numbers not the <7> 

i++; 
}

so my array would be now :
 2 1 2 4 3000 3500 2070 2500 
(2,1,2,4 are function id's such as 2 = ip_forward
entry, 1 = ip_forward exit and so on and the rest of
the array is the correspong times) 

from here i have no problem working on these results
using stacks etc.

 all this is fine, if i could get my results on one
line in the original trace file but as i found out
this is not the case. 

so how can i turn off printing
"jul 20 13:50 homer kernel:" entirely or solve the
repeated "jul 20 13:50 homer kernel:" print outs? 

is it to do with the printk.c file or syslog.c or
klog.c files? (i can't find syslog.c or klog.c files,
i
assumed the existed as something runs syslogd and
klogd) 

many thanks in advance,
william

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
