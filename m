Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284755AbRLKAmm>; Mon, 10 Dec 2001 19:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284762AbRLKAmd>; Mon, 10 Dec 2001 19:42:33 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:13261 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284755AbRLKAmX>; Mon, 10 Dec 2001 19:42:23 -0500
Message-ID: <3C15566B.7010803@redhat.com>
Date: Mon, 10 Dec 2001 19:42:19 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011010 Netscape6/6.1b1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andris Pavenis <pavenis@latnet.lv>
CC: Nathan Bryant <nbryant@optonline.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i810_audio fix for version 0.11
In-Reply-To: <Pine.A41.4.05.10112081022560.23064-100000@ieva06> <200112080925.fB89PJ200926@hal.astr.lu.lv> <3C11DF15.1020107@redhat.com> <200112080945.fB89jAC00998@hal.astr.lu.lv>
Content-Type: text/plain; charset=ISO-8859-13; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andris Pavenis wrote:

> Why returning non zero from __start_dac() and similar procedures when 
> something real has been done there is so bad. 


Personal preference.

> Using such return code would
> ensure we never try to wait for results of __start_dac() if nothing is done 
> by this procedure.


That's part of the point.  In this driver, I try to control when things are 
done and keep track of them in a deterministic way.  Using a return code to 
tell us a function we called did nothing when we shouldn't have called it in 
the first place if it wasn't going to do anything is backwards from the way 
I prefer to handle things.  Namely, find out why the function was called 
when it shouldn't have been and solve the problem.  Note: I don't follow 
that philosophy on all functions, only on very simple ones like this, there 
are a lot of complex functions where you want the function to make those 
decisions.  So, like I said, personal preference on how to handle these things.

> I think such way is also more safe against possible future 
> modifications as real conditions are only in a single place. Keeping them in 
> 2 places is possible source of bitrot if driver will be updated in future.


It's intended to do exactly that.  A lot of what makes this driver work 
properly right now is the LVI handling.  That was severly busted when I 
first got hold of the driver.  I *want* things to break if the LVI handling 
is changed by someone else because that will alert me to the fact that the 
LVI handling is then busted (at least, if they change it incorrectly, if 
they do things right then they will catch problems like this and fix them 
properly and I won't have to do anything).





-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

