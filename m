Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266108AbUFJERT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266108AbUFJERT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 00:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266110AbUFJERS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 00:17:18 -0400
Received: from web14202.mail.yahoo.com ([216.136.172.144]:21024 "HELO
	web14202.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266108AbUFJEQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 00:16:41 -0400
Message-ID: <20040610041641.80112.qmail@web14202.mail.yahoo.com>
Date: Wed, 9 Jun 2004 21:16:41 -0700 (PDT)
From: "j.random.programmer" <javadesigner@yahoo.com>
Subject: Threading behavior in 2.6.5 may be broken ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

I just installed Fedora Core 2 (2.6.5.x smp 
kernel) on a Dual 1 Ghz P4 server with about 
1.5 GB of RAM and about 1.4 GB of swap. 

I am primarily a web/database developer, not 
a C programmer so I am writing this email from
an end-user's perspective.

I have a program that tries to create as many
threads as possible. This program was written by me 
for kicks/testing -- just to see what would happen.
I ssh into the server and run this program as root
under the sun 1.4.2 JDK.

On a 2.4.x kernel, from a Java JVM I could create
about 900 threads before the JVM crapped out with
a "cannot create more threads" type of error. Before
this point, I can create/run - say 700 threads - just
fine. This is good -- a clean failure at some point
and good behavior before then.

On this new kernel, the system gets totally wedged
when I run the same program and try to create
10,000 threads. Instead of getting a "cannot
create more threads" error, I now get an "out of
memory" error. Then the command line freezes in
the existing terminal window, ctrl+c does not work
(no matter how many times it's pressed), I cannot
launch another ssh session and cannot ssh into the
server again (although ping still works).

To recap:

[2.4.x]
700 threads --> fine
10,000 threads --> crap out at 900 something. 

[2.6.5]
700 threads --> fine
10,000 threads --> system wedged totally. 

I thought NPTL would create/run threads as if there
was no tomorrow ? So why do things seem to be worse
in 2.6.x ?

For right now, I'm going back to slackware with 2.4.x
but it would be great if someone fixed this problem
in future 2.6 kernels. [As as aside, I can create
as many threads as I want, say 20,000, without
any problems using the same program on my mac-osx
laptop].

I'd be happy to give a known kernel hackers on this
list root access to this box for the next few days 
if anyone is interested in seeing/poking around
for themselves (email me if so desired).

Best regards,

--j
javadesigner@yahoo.com

------------- The test program is shown below --------

/** Usage: java MaxThreads number-of-threads */
public class MaxThreads extends Thread
{
static int threadnum = 0;
public static void main(String args[])
	{
	if (args.length != 1) {
     System.out.println("java MaxThreads
num_threads");
     System.exit(1);
     }
	int n = Integer.parseInt(args[0]);
	System.out.println("test " + n + " threads..");
	for (int i=0 ; i < n; i++) {
		Thread t = new MaxThreads();
		t.start();
		}
	}

public void run() { 
	try {
		currentThread().sleep(5000); //5 sec
		System.out.println(
        "Thread:" + threadnum++ + "..done");
		}
	catch (Exception e) { e.printStackTrace(); }
	}
}           //~class MaxThreads
--------------------------------------------------









 


	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
