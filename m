Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbRDARYW>; Sun, 1 Apr 2001 13:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132520AbRDARYM>; Sun, 1 Apr 2001 13:24:12 -0400
Received: from smtp1.clinet.fi ([194.100.2.57]:57870 "HELO smtp1.clinet.fi")
	by vger.kernel.org with SMTP id <S131191AbRDARYC>;
	Sun, 1 Apr 2001 13:24:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dennis Noordsij <dennis.noordsij@wiral.com>
To: linux-kernel@vger.kernel.org
Subject: pthreads & fork & execve
Date: Fri, 30 Mar 2001 16:22:57 +0300
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01033016225700.00409@dennis>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have question regarding use of pthreads, forks and execve's which appears 
to not work very well :-) First let me explain the reasoning though

We have an app that launches a few other apps and keeps track of their 
status, resource consumption etc. If one of the apps crashes, it is restarted 
according to certain parameters.

The app uses pthreads, and it's method of (re)starting an application is 
forking and calling execve. 

It works fine for all-but-one other app, which core dumps when started this 
way (from the commandline it works fine) and the core only traces back to  
int main(int argc, char **argv). It uses both pthreads and -ldl for plugin 
handling. 

We have tried changing the linking order (i.e. -ldl -lpthread, -lpthread, 
-ldl, etc), and even execv'ing a shell script that starts a shell script that 
starts the app - result is the same, instant core without even running.

I can see who forks together with threads and execve's are a messy 
combination, and a better solution altogether to our approach is appreciated 
just as much as a way to make the current solution work :-)

We have tested both kernels 2.4.2 and 2.2.18. 

We have tried on different systems, different hardware and slightly different 
distributions (debian potato, unstable, etc).

To sum up: using a pthreaded app to launch another pthreaded app by means of 
forking and exec(ve)'ng makes the second app core immediately, (at entering 
main). What to do?

Kind regards, and thanks for any help
Dennis Noordsij
