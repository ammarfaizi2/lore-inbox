Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266516AbRGLSt2>; Thu, 12 Jul 2001 14:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266508AbRGLStJ>; Thu, 12 Jul 2001 14:49:09 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:26762
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S266507AbRGLSsx>; Thu, 12 Jul 2001 14:48:53 -0400
Message-ID: <3B4DF114.44272B74@nortelnetworks.com>
Date: Thu, 12 Jul 2001 14:48:52 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting?
In-Reply-To: <200107121623.f6CGNV569053@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:

> The 24x7 places might be willing to pay somebody to do this.
> It's consulting work really. The customer says "I want to go
> from 2.4.8 to 2.4.12", you say "OK, $320405 please.", and you
> make a custom upgrade procedure for them.

Speaking as someone who is working on what will eventually be a five 9's project
based on linux, there is almost zero chance that we would make use of something
like this.  Applications and kernels are tested together and verified together,
and the likelihood of changing either one and not the other one is very low (and
in fact they are shipped together as a single image).

We have hardware redundancy, and upgrades are controlled by the application,
since it knows exactly what state must be transferred and what the differences
are between versions.  After all the state has been transferred we then do an IP
takeover so that the rest of the system knows to talk to the new side.  At this
point we can test the new side for a while.  If we're satisfied with how its
performing, we can then take down the inactive side and upgrade it and then
bring it back into sync with the active side.  If we don't like it, we can
always abort and switch back to the old version.

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
