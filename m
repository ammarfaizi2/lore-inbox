Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUALMYU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 07:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266178AbUALMYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 07:24:20 -0500
Received: from tataelxsi.co.in ([203.197.168.150]:38153 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S266175AbUALMYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 07:24:12 -0500
Reply-To: <vijayabhaskar@tataelxsi.co.in>
From: "VIJAYABHASKAR" <vijayabhaskar@tataelxsi.co.in>
To: <krishnakumar@naturesoft.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Very Urgent !! (2'nd Post)  Not able to recieve messages using sock_recvmsg()
Date: Mon, 12 Jan 2004 17:51:22 +0530
Message-ID: <004101c3d906$97b26d30$501e010a@telxsi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
In-Reply-To: <200401121736.09720.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI Krishna,
It is not printing the length,stucking in that statement it self.
I am sending about 10 characters from the client
client using the following code to send:
 char buf[10]="123456789";

        iov.iov_base=(void *)buf;
        iov.iov_len=(size_t)10;

        msg.msg_name=NULL;
        msg.msg_namelen=0; //sizeof(server);
        msg.msg_iov=&iov;
        msg.msg_iovlen=1;
        msg.msg_control=NULL;
        msg.msg_controllen=0;
        msg.msg_flags = 0;

 for (i=0;i<NUM_PACKAGE;i++)
                {
                 //strcpy(buf,"1");

                 oldfs = get_fs(); set_fs(KERNEL_DS);
                 error = sock_sendmsg(Socket[0], &msg,10);

                /* len = sock_recvmsg(Socket[0], &msg, (size_t)buf, 0);
                 set_fs(oldfs);

                 if (len<0)
                        printk(KERN_ALERT "ERRO receive ########\n");*/

                 if (error<0)
                        printk(KERN_ALERT "Erro send msg ERRO = %d
buf=%s\n",error,buf);
}

Server side using the following code:

iov.iov_base = (void *)buf;
        iov.iov_len = (size_t)10;

        msg.msg_name = NULL;
        msg.msg_namelen = 0;
        msg.msg_iov = &iov;
        msg.msg_iovlen = 1;
        msg.msg_control = NULL;
        msg.msg_controllen = 0;
        msg.msg_flags = 0;

        len = 0;
for (i=0;i<1;i++)
                {
                 oldfs = get_fs(); set_fs(KERNEL_DS);
                 printk(KERN_ALERT " before recieving message \n");
                 len = sock_recvmsg(newsock, &msg,10, 0);
                 printk( KERN_ALERT " Recieved message length is %d
\n",len);
                 printk( KERN_ALERT "recieved message is %s",buf);

}

Am i doing wrong??
Please clarify...
Thanks
Bhaskar
-----Original Message-----
From: Krishnakumar. R [mailto:krishnakumar@naturesoft.net]
Sent: Monday, January 12, 2004 5:36 PM
To: vijayabhaskar@tataelxsi.co.in
Subject: Re: Very Urgent !! (2'nd Post) Not able to recieve messages
using sock_recvmsg()


Hello Bhaskar,

What is the return value you are getting.
ie. Did you try printing the return value
and see what is being printed.

Some thing like the following.

>  len = sock_recvmsg(newsock, &msg, (size_t)buf, 0)

printk("Return value = %d \n", len);

> printk( KERN_ALERT "recieved message is %s",buf)


Hope that helps,
Regards,
KK.

PS: Are you an alumni of GEC TCR ?


