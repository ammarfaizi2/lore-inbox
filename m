Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293315AbSBYEiD>; Sun, 24 Feb 2002 23:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293316AbSBYEhx>; Sun, 24 Feb 2002 23:37:53 -0500
Received: from 12-226-21-207.client.attbi.com ([12.226.21.207]:54008 "EHLO
	spartan.jdc.home") by vger.kernel.org with ESMTP id <S293315AbSBYEhh>;
	Sun, 24 Feb 2002 23:37:37 -0500
Message-ID: <3C79BF6D.8000206@noth.is.eleet.ca>
Date: Sun, 24 Feb 2002 23:37:01 -0500
From: Jim Crilly <noth@noth.is.eleet.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: mlock + OOM = infinite loop
In-Reply-To: <3C797F82.4000602@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a dual Athlon 1.2Ghz box with 1.2G of memory, I decided to run 2 
copies of memtest to test the memory with each testing 629M (the 
existance of memtest86 slipped my mind). With the 2.4.17 and 2.4.18-rc2 
kernels (Andre's IDE amd kdb patches applied) the kernel loops trying to 
free memory so the second mlock can succeed which never happens, I let 
it run for about 2 days while I was away and it never became responsive, 
minus kdb.

But with Rik's rmap12a patch it successfully starts the OOM and kills 
one of the memtest processes, the only strange thing is it kills the 
first instance letting the second succeed, I would think it would be 
nicer to just fail in the second mlock and let the first continue.

Also all the kernels were compiled with SMP support, if that makes a 
difference.

Jim

