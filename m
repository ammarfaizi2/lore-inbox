Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265415AbUAJVa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 16:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbUAJVa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 16:30:26 -0500
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:45219 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S265415AbUAJVaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 16:30:19 -0500
Subject: Re: 2.4.23: user/kernel pointer bugs (drivers/char/vt.c,
	drivers/char/drm/gamma_dma.c)
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
FCC: imap://rtjohnso@imap.cs.berkeley.edu/Sent
X-Identity-Key: id1
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105
	Thunderbird/0.3
X-Accept-Language: en-us, en
References: <1073592494.18588.77.camel@dooby.cs.berkeley.edu>
	<Pine.LNX.4.58L.0401101543410.4057@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0401101543410.4057@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 10 Jan 2004 13:30:16 -0800
Message-Id: <1073770216.22193.79.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

    On Thu, 8 Jan 2004, Robert T. Johnson wrote:
    
      
        Both of these bugs look exploitable.  The vt.c patch is
        self-explanatory.
        
        Thanks for looking at this, and let me know if you have any questions.
        
        Best,
        Rob
        
        P.S. Both of these bugs were found using the source code verification
        tool, CQual, developed by Jeff Foster, myself, and others, and available
        from http://www.cs.umd.edu/~jfoster/cqual/.
        
        
        --- drivers/char/vt.c.orig	Thu Jan  8 10:53:01 2004
        +++ drivers/char/vt.c	Wed Jan  7 15:22:17 2004
        @@ -288,7 +288,7 @@
         	case KDGKBSENT:
         		sz = sizeof(tmp.kb_string) - 1; /* sz should have been
         						  a struct member */
        -		q = user_kdgkb->kb_string;
        +		q = tmp.kb_string;
         		p = func_table[i];
         		if(p)
         			for ( ; *p && sz; p++, sz--)
            
    The "q" variable is only used as an argument to put_user() (the kernel is
    not reading from that address), so I think it is not a problem.
    
    I think your patch will break the ioctl.
      
Whoops.  I thought user_kdgkb->kb_string was a pointer, not an array. 
You're absolutely right.  Please ignore this patch.  I'm very sorry for
the mistake.

Best,
Rob


