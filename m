Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAEOk2>; Fri, 5 Jan 2001 09:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRAEOkT>; Fri, 5 Jan 2001 09:40:19 -0500
Received: from h57s242a129n47.user.nortelnetworks.com ([47.129.242.57]:25315
	"EHLO zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S129401AbRAEOkN>; Fri, 5 Jan 2001 09:40:13 -0500
Message-ID: <3A55DC2E.9C342224@nortelnetworks.com>
Date: Fri, 05 Jan 2001 09:37:34 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; HP-UX B.10.20 9000/778)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Bartz <md-linux-kernel@logi.cc>
CC: linux-kernel@vger.kernel.org
Subject: Re: Anyone else interested in a high-precision monotonic counter?
In-Reply-To: <Pine.BSF.4.21.0012180711330.89819-100000@beppo.feral.com> <3A3E336C.B29BBA89@nortelnetworks.com> <14912.11470.540247.408234@diego.linuxcare.com.au> <3A550AC8.D22D0CE4@nortelnetworks.com> <20010105032900.22980.qmail@logi.cc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Bartz wrote:

> Why a new system call?
Well, you'd be accessing a different kernel variable--"ytime" instead of
"xtime". This new variable wouldn't be adjusted when the  system
time/date was, it would start at zero and always increase. 
 
> regarding a:  it could have microsecond resolution but not
>               microseconds accuracy.

On PPC and x86 systems, gettimeofday() is both accurate and precise to
microseconds, since it is based off of jiffies and then offset to get
microseconds.


> regarding b:  have you looked at the return-value of times(2)
>               Or roll your own using setitimer(2)

Both of these are precise only to jiffies, which defaults at 10
milliseconds on x86 and PPC.  If you want microsecond timing, the only
current standard way to do it is to use gettimeofday(), which is
sensitive to changes in system date and time.




-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
