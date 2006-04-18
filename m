Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWDRPex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWDRPex (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 11:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWDRPex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 11:34:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:21688 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932137AbWDRPew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 11:34:52 -0400
X-Authenticated: #13409387
Message-ID: <444503D1.50705@gmx.net>
Date: Tue, 18 Apr 2006 17:20:49 +0200
From: Gunther Mayer <gunther.mayer@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zinx Verituse <zinx@epicsol.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd.c, "MEDIUM_ERROR" handling
References: <20060418011839.GA10619@atlantis.chaos>
In-Reply-To: <20060418011839.GA10619@atlantis.chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zinx Verituse wrote:

>I recently bought a DVD drive which appears to not retry enough when it's
>having trouble reading a disc - I'm requesting an option (or changing the
>default behavior) so that this drive is actually usable with the Linux
>ide-cd drivers - specificly, the code:
>	} else if (sense_key == MEDIUM_ERROR) {
>		/* No point in re-trying a zillion times on a bad
>		 * sector...  If we got here the error is not correctable */
>		ide_dump_status (drive, "media error (bad sector)", stat);
>		do_end_request = 1;
>	}
>needs to be disabled for my drive to read CDs properly.
>
>With this code enabled, no retries are made, and the kernel sees medium errors
>and returns bad data to the application reading; 
>
It would be a kernel bug if it returns bad data. It should return an 
error code to the application.

- The device should implement a decent retry strategy.
- There are special forensic applications which can be tuned to re-read 
bad sectors multiple times if needed.
