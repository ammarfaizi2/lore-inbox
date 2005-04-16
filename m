Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVDPEvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVDPEvP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 00:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVDPEvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 00:51:15 -0400
Received: from hacksaw.org ([66.92.70.107]:32432 "EHLO hacksaw.org")
	by vger.kernel.org with ESMTP id S261678AbVDPEvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 00:51:10 -0400
Message-Id: <200504160450.j3G4oqC9029496@hacksaw.org>
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.0.4
To: linux-os@analogic.com
cc: "Theodore Ts'o" <tytso@mit.edu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Tomko <tomko@haha.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Why system call need to copy the date from the userspace before 
 using it
In-reply-to: Your message of "Wed, 13 Apr 2005 15:20:38 EDT."
             <Pine.LNX.4.61.0504131507280.21367@chaos.analogic.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Apr 2005 00:50:52 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this bugs anyone, but I'm learning things here.

What I would expect the kernel to do is this:

system_call_data_prep (userdata, size){	

   if !4G/4G {
      for each page from userdata to userdata+size
      {
 	if the page is swapped out, swap it in
	if the page is not owned by the user process, return -ENOWAYMAN
	otherwise, lock the page
      }
      return userdata;
    }
    else { //kernel land and userland are mutually exclusive
	   copy the data into kernel land
	   return kernelland_copy_of_userdata;
          }
}

(And then the syscall would need to run the opposite function 
sys_call_data_unprep to unlock pages.)

Hmm, maybe that interface sucks.

Is it anything close to that? 
   
-- 
The best is the enemy of the good  -- Voltaire
The Good Enough is the enemy of the Great -- Me
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


