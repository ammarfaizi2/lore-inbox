Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269498AbUJFVUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269498AbUJFVUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269380AbUJFUrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:47:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32153 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269485AbUJFUmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:42:07 -0400
Message-ID: <41645892.9060105@redhat.com>
Date: Wed, 06 Oct 2004 16:41:54 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hzhong@cisco.com
CC: "'Andries Brouwer'" <aebr@win.tue.nl>,
       "'Joris van Rantwijk'" <joris@eljakim.nl>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <003301c4abdc$c043f350$b83147ab@amer.cisco.com>
In-Reply-To: <003301c4abdc$c043f350$b83147ab@amer.cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong wrote:
>>It may need fixing in the sense that it must point out that 
>>the Linux kernel
>>might not conform to POSIX in its handling of select on sockets.
> 
> 
> Agreed.
> 
> 
>>We now not only have "man 2 select", but also "man 3p select".
>>This is the POSIX text:
>>
>>       A  descriptor shall be considered ready for reading when a
>>       call to an input function with O_NONBLOCK clear would  not
>>       block,  whether  or  not  the function would transfer data
>>       successfully. (The function might return data, an  end-of-
>>       file  indication,  or  an  error other than one indicating
>>       that it is  blocked,  and  in  each  of  these  cases  the
>>       descriptor shall be considered ready for reading.)
>>
>>As far as I can interpret these sentences, Linux does not conform.
> 

Again, shouldn't this just mean that recvfrom should not be called 
without the MSG_ERRQUEUE flag set?  From the above description, I read 
that select returning with an indication that a descriptor is ready for 
reading could mean that it has an error message queued to it, rather 
than in-band data.  If you then call recvfrom/recv/recvmsg without 
indicating that you want to receive the error indications as well, then 
isn't that just another example of improper coding, since recvfrom would 
have returned immeidately, as select indicated, had the appropriate read 
flags been set?

Neil
> 
> How hard is it to treat the next read to the fd as NON_BLOCKING, even if
> it's not set?
> 
> 
>>Andries
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
