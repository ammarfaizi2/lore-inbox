Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285935AbSAHT7X>; Tue, 8 Jan 2002 14:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286137AbSAHT7O>; Tue, 8 Jan 2002 14:59:14 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:4153 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S285935AbSAHT64>; Tue, 8 Jan 2002 14:58:56 -0500
Message-ID: <3C3B4F7F.8010901@redhat.com>
Date: Tue, 08 Jan 2002 14:58:55 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: willy tarreau <wtarreau@yahoo.fr>
CC: Mario Mikocevic <mozgy@hinet.hr>, linux-kernel@vger.kernel.org
Subject: Re: i810_audio
In-Reply-To: <20020108163141.57751.qmail@web20507.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

willy tarreau wrote:

>>i810_audio.c:747: `PI_OR' undeclared (first use in
>>
> this function)
> 
> Replace PI_OR with PO_SR. It compiled for me after
> that.
> But my system still hangs after close while Thomas
> Gschwidt's
> patch works OK.


Someone posted one of the DMA Overrun on write error messages to me, and 
that allowed me to see that on the SiS hardware we are getting garbage in 
the upper 3 bits of the LVI register (presumably because we read garbage 
from the upper 3 bits of the CIV register).  So, I've put a 0.15 version of 
my driver on my site that now bounds our LVI and CIV reads so that we mask 
out any possible garbage.  And, since writing garbage to LVI could keep the 
hardware going in loops forever and other sorts of bad things, it might 
solve your problem.  Please give it a try and let me know how it works.





-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

