Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRADXuk>; Thu, 4 Jan 2001 18:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbRADXub>; Thu, 4 Jan 2001 18:50:31 -0500
Received: from h57s242a129n47.user.nortelnetworks.com ([47.129.242.57]:9209
	"EHLO zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S129267AbRADXuX>; Thu, 4 Jan 2001 18:50:23 -0500
Message-ID: <3A550AC8.D22D0CE4@nortelnetworks.com>
Date: Thu, 04 Jan 2001 18:44:08 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; HP-UX B.10.20 9000/778)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Anyone else interested in a high-precision monotonic counter?
In-Reply-To: <Pine.BSF.4.21.0012180711330.89819-100000@beppo.feral.com> <3A3E336C.B29BBA89@nortelnetworks.com> <14912.11470.540247.408234@diego.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Has anyone ever considered including a microsecond-precision
monotonically-increasing counter in the kernel?  This would allow for
easy timing of alarms and such by using absolute values of when the
alarm should expire rather than a list of deltas from previous alarms.

The thing I have in mind would store a value something like "xtime"
(maybe call it "ytime"?) in the kernel.  This value would be initialized
to zero on startup, and would be incremented at the same time as
"xtime".  However, while "xtime" reflects adjustments to the actual
system time (settimeofday(), date, ntp, etc.), this value would not. 
Finally, it would be accessed with a system call essentially identical
to sys_gettimeofday(), only it would access "ytime" instead of "xtime"
before going down and getting the microseconds from the RTC.

This doesn't seem to me as though it would be all that tricky to add,
and I could see it being very useful in providing a timing source that
is guaranteed to a) be accurate to microseconds and b) never go
backwards.


Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
