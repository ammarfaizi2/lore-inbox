Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272550AbRH3XQY>; Thu, 30 Aug 2001 19:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272553AbRH3XQO>; Thu, 30 Aug 2001 19:16:14 -0400
Received: from t2.redhat.com ([199.183.24.243]:46327 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S272550AbRH3XQE>; Thu, 30 Aug 2001 19:16:04 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.3.95.1010830171614.18406A-100000@chaos.analogic.com> 
In-Reply-To: <Pine.LNX.3.95.1010830171614.18406A-100000@chaos.analogic.com> 
To: root@chaos.analogic.com
Cc: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>,
        linux-kernel@vger.kernel.org, ptb@it.uc3m.es
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 31 Aug 2001 00:16:07 +0100
Message-ID: <13173.999213367@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


root@chaos.analogic.com said:
> /tmp/xxx.c:9: warning: signed and unsigned type in conditional expression 
> As you can see, the casts are !!!IGNORED!!! in gcc 2.96.

No, if the casts were ignored, it would complain:
/tmp/xxx.c:9: warning: comparison between signed and unsigned

What gcc 2.96 is complaining about is not the comparison in the 
condition, but the the fact that the two possible
results of your conditional expression (x?a:b) are different. 

Change it to read:
	#define MIN(a, b) ((a) < (b) ? (int)(a) : (int)(b)) 
... and you'll see the warning you thought you saw before. 

	#define MIN(a, b) ((a) < (b) ? (a) : (b))
... and you'll see both.

--
dwmw2


