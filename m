Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287545AbSBDTzw>; Mon, 4 Feb 2002 14:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287699AbSBDTzo>; Mon, 4 Feb 2002 14:55:44 -0500
Received: from ua0d5hel.dial.kolumbus.fi ([62.248.132.0]:7978 "EHLO
	porkkala.uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S287545AbSBDTzf>; Mon, 4 Feb 2002 14:55:35 -0500
Message-ID: <3C5EE691.1E7C2ADF@kolumbus.fi>
Date: Mon, 04 Feb 2002 21:52:49 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Ed Tomlinson <tomlins@cam.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <Pine.LNX.4.33.0202040137070.19391-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> 'response' in terms of interactive latencies should be good, yes.
> 
> 'response' in terms of relative CPU time given to CPU hogs and 
> interactive tasks wont be as 'good' as with the old scheduler. (ie. CPU 
> hogs *will* be punished harder - this is what is needed for good 
> interactivity after all.) So if you see that some of your interactive 

How about priority inheritance? When interactive task relies heavily on
output from CPU hog?

My application uses three tier architecture where is low HAL layer reading
audio from soundcard which is compressed and sent (TCP) to distributor
process which decompresses the audio and distributes (UNIX/LOCAL) it to
clients. Distributor's clients are the CPU hogs doing various processing
tasks to the signal and then sending (TCP) the results to the very thin user
interface.

Now the user interface can take some CPU time and is considered to be
interactive. But if that leads to starvation of CPU hog processing tasks it
leads to unusable output on user interface because starvation leads to
losing blocks of data in distributor process.

HAL and distributor are running as SCHED_FIFO, but CPU hog processing tasks
are dynamically fork()/exec()'d and run on default priority (not as root).
So I should nice user interfaces to 15+?

App can be found from: http://hasas.sf.net


	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

