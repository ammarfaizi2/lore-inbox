Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261749AbTCaSPm>; Mon, 31 Mar 2003 13:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261759AbTCaSPm>; Mon, 31 Mar 2003 13:15:42 -0500
Received: from pointblue.com.pl ([62.89.73.6]:35340 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id <S261749AbTCaSPk>;
	Mon, 31 Mar 2003 13:15:40 -0500
Subject: attempt to free, allready freed memory .. rfc
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: K4 Labs
Message-Id: <1049134044.945.35.camel@gregs>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 31 Mar 2003 19:07:25 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !
As allways, i have a problem. Thus i want ask you for comment.

Today i had a strange problem with my customers program. It is very
fresh soft, and they are still strugling with it (developing i meant :-)
). But they were stucked on very strange problem. 

[explanation of problem in program- ommited]

Problem it self.

this code will be an example.

struct doom{
        int data1;
        int data2;
        void *mydata;
};

doom doomed;

void dosomething_with_data(doom *d)
{       
//      .... doing some fancy operations
//      then..
        if (d->mydata)
        {
                free(d->mydata);
                d->mydata=NULL;
        }
}

void main()
{
        int i,j;
        void *t;

        // this program is just not doing anything important :-)
        
        t=doomed.mydata=malloc(somenumberofbytes);
        if (t==NULL){
                return;
        }
        
        dosomething_with_data(&doomed); 

// plenty of lines and finally ........
        if (doomed.mydata)
        {
                free(doomed.mydata);
                doomed.mydata=NULL;
        }

// now i will get strange behavior in other structures
// seems like it is a memory leak.....
 
}

well, finding this error in somebody software was not easy. 
Finaly i tested simmilar behavior on windows, and... it was not better.
But under compilation with m$ comiler in debug mode gived me assert on
first attempt to free allready freed memory. 
Is this behavior system has to take ? (i mean segfault)
which options for gcc i have to use to get assertion in case of such
error (i guess malloc seats in glibc, thus debug version of this liblary
might have this). But i am not sure. Waiting for comments. 
  

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 Labs

