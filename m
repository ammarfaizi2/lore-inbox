Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbQLRQ2x>; Mon, 18 Dec 2000 11:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLRQ2q>; Mon, 18 Dec 2000 11:28:46 -0500
Received: from h57s242a129n47.user.nortelnetworks.com ([47.129.242.57]:12436
	"EHLO zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S131497AbQLRQ2e>; Mon, 18 Dec 2000 11:28:34 -0500
Message-ID: <3A3E336C.B29BBA89@nortelnetworks.com>
Date: Mon, 18 Dec 2000 10:55:24 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; HP-UX B.10.20 9000/778)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org
Subject: gettimeofday() non-monotonic on uniprocessor system with ntp turned 
         off?
In-Reply-To: <Pine.BSF.4.21.0012180711330.89819-100000@beppo.feral.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am having a little bit of a problem.  I'm on a single processor G4 system
running 2.2.17 and I do not have ntp turned on.  However, successive calls to
gettimeofday() occasionally return results that make it look as though time was
running backwards.  

To test this, I wrote a small program that does a loop and calls gettimeofday(),
comparing the result to the previous time around.  If the latest call is
"earlier" than the previous one, it prints both out as well as the difference
between the two.  Here is some of the results:

time1             time2             delta
977032354.149970  977032354.140019  0.009951
977032507.119949  977032507.110004  0.009945
977032806.429940  977032806.420004  0.009936
977032822.349971  977032822.340008  0.009963
977032989.739968  977032989.730015  0.009953
977033057.579978  977033057.570006  0.009972
977033065.269950  977033065.260023  0.009927
977033155.499958  977033155.490030  0.009928
977033205.799960  977033205.790029  0.009931
977033279.919965  977033279.910024  0.009941
977033367.589953  977033367.580008  0.009945
977033454.509977  977033454.500030  0.009947
977033457.359965  977033457.350003  0.009962
977033500.619954  977033500.610011  0.009943
977033509.679964  977033509.670020  0.009944
977033659.439972  977033659.430003  0.009969
977033842.399966  977033842.390019  0.009947
977034023.419976  977034023.410023  0.009953
977034026.019983  977034026.010011  0.009972
977034085.899979  977034085.890032  0.009947
977034176.219956  977034176.210013  0.009943
977034691.289969  977034691.280026  0.009943
977034845.569984  977034845.560024  0.009960

It appears that the problem happens only when the first time reading is very
close to the end of a jiffy period.  It almost seems like the microseconds value
rolls over to the new jiffy, then the program reads the value before the seconds
value catches up.  

Is this a known issue?  Has anyone fixed this already?  I'm kind of surprised
that something like this is still around.

Thanks,

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
