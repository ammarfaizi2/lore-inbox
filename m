Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbSADVmc>; Fri, 4 Jan 2002 16:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281797AbSADVmW>; Fri, 4 Jan 2002 16:42:22 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:54940 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S280588AbSADVmT>; Fri, 4 Jan 2002 16:42:19 -0500
Message-ID: <3C362308.E36E0B02@nortelnetworks.com>
Date: Fri, 04 Jan 2002 16:47:52 -0500
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel log messages using wrong timezone -- solved
In-Reply-To: <3C360D22.F6FFFAD6@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Friesen, Christopher [CAR:3R60:EXCH]" wrote:
> 
> How does the kernel figure out how to timestamp the log output?  The reason I'm
> asking is that we have a system that has /etc/localtime pointing to the
> Americas/Montreal timezone, but the log output from the kernel appears to be
> UTC.

Well, it turns out that klogd was the culprit.  We were booting a ramdisk,
setting the time, starting syslog, and then setting the timezone from an
NFS-mounted file.  klogd checks the timezone on startup only, so changing the
timezone did not affect the output of klogd.  Guess we'll have to restart syslog
after setting the timezone.

Thanks to those who responded.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
