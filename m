Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132795AbRC2RRD>; Thu, 29 Mar 2001 12:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132796AbRC2RQx>; Thu, 29 Mar 2001 12:16:53 -0500
Received: from atlrel2.hp.com ([156.153.255.202]:17393 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S132795AbRC2RQk>;
	Thu, 29 Mar 2001 12:16:40 -0500
Message-ID: <3AC36DB2.64C9A3D1@fc.hp.com>
Date: Thu, 29 Mar 2001 10:15:30 -0700
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eli Carter <eli.carter@inet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rate limiting error messages
In-Reply-To: <3AC3659D.BD56E640@inet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Carter wrote:
> 
> Can someone point me to a "standard way" of doing rate limiting of error
> messages in the kernel?
> 
> TIA,
> 
> Eli
> -----------------------.           Rule of Accuracy: When working toward
> Eli Carter             |            the solution of a problem, it always
> eli.carter(at)inet.com `------------------ helps if you know the answer.

Here is how it is done in IA-64 kernel:

static int
within_logging_rate_limit (void)
{
        static unsigned long count, last_time;

        if (count > 5 && jiffies - last_time > 5*HZ)
                count = 0;
        if (++count < 5) {
                last_time = jiffies;
                return 1;
        }
        return 0;

}

If this fundction returns 0, error messages have been rate limited. This
code is not MP-safe. So, if you need your code to be MP-safe, you may
need to rewrite it somewhat.

-- 
Khalid

====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
