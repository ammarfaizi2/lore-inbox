Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVFBGgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVFBGgS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 02:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVFBGgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 02:36:18 -0400
Received: from web51105.mail.yahoo.com ([206.190.38.147]:56455 "HELO
	web51105.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261584AbVFBGf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 02:35:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=cAaOworg+0OHnou214B5IBGH0XdAoJQbUlTxvsehrPGyjqNCAx0utKUvfG9/z8BqG/VvJFoxex5z+XQasFQ7bhiRkAkkFznSow5bJGcWUgM3yq0A5OvzETtIfPqWZsYrGwp7RtSGoyRHh88kqRsrC+PJRKF6osecIi0W55wLzkU=  ;
Message-ID: <20050602063558.68968.qmail@web51105.mail.yahoo.com>
Date: Wed, 1 Jun 2005 23:35:58 -0700 (PDT)
From: baswaraj kasture <kbaswaraj@yahoo.com>
Subject: Problem with __alt_instructions array on IA-32
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am building linux kernel 2.6.9-6 with Intel
Compiler.
Compilation is successfull.
While booting, kernel panic is reprted.
I also found the place of kernel panic. It is in
"apply_alternatives" function. Commenting this
function boots the kernel, but then there are Xserver
and network related problems.

I found that  in __alt_instructions is array of
structures of "alt_instr".

struct alt_instr {
        __u8 *instr;            /* original
instruction */
        __u8 *replacement;
        __u8  cpuid;            /* cpuid bit set for
replacement */
        __u8  instrlen;         /* length of original
instruction */
        __u8  replacementlen;   /* length of new
instruction, <= instrlen */
        __u8  pad;
};


While debuging it is found that this array has NULL
value for member 'instr' (except first ).

i.e. __alt_instrctions[1].instr ,
__alt_instrctions[2].instr , ... are all NULL.

This causes Kernel panic.

Could you please suggest why these member are NULL ?

Thanks in advance.

-Baswaraj


		
__________________________________ 
Discover Yahoo! 
Use Yahoo! to plan a weekend, have fun online and more. Check it out! 
http://discover.yahoo.com/
