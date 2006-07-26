Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbWGZXl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWGZXl6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 19:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWGZXl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 19:41:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:19369 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751814AbWGZXl6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 19:41:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p0MdMOrDoqUYR4rur1HAM5v42U2lUlReMd4ks+LzJ9iKtpjF6/upy8s03rwLQFDkSONWgIdZNbaluDOF9/I9QyfeUZsfSi/zrCY2pD53C01HFSJ586dtckR8itcNBKuA+7+8msjR/sz4zljZyDqBRPC/DTHd5dqi7a/QPaycFkk=
Message-ID: <c526a04b0607261641n7f09242h86025282153e4c91@mail.gmail.com>
Date: Thu, 27 Jul 2006 00:41:56 +0100
From: "Adam Henley" <adamazing@gmail.com>
To: "=?ISO-8859-1?Q?S=E9bastien_Bernard?=" <seb@frankengul.org>
Subject: Re: Weird kernel 2.6.17.[67] behaviour
Cc: debian-sparc@lists.debian.org, linux-kernel@vger.kernel.org
In-Reply-To: <44C7F794.3080304@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060726135526.GA11310@frankengul.org>
	 <44C7F794.3080304@frankengul.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/06, Sébastien Bernard <seb@frankengul.org> wrote:
> seb@frankengul.org a écrit :
> > I got a perfectly workable kernel 2.6.17.1 using mkinitramfs on my U60.
> >
> > Can you shed some lights on this dark corner of linux ?
> >
> >       Seb

I can't shed any more light on it, but I can look too :o)

The original mailing of the patch to the list is below:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0607.1/1694.html

[snip>
The prctl() system call should never allow to set "dumpable" to the
value 2. Especially not for non-privileged users.

This can be split into three cases:
  1) running as root -- then core dumps will already be done as root,
     and so prctl(PR_SET_DUMPABLE, 2) is not useful
  2) running as non-root w/setuid-to-root -- this is the debatable case
  3) running as non-root w/setuid-to-non-root -- then you definitely
     do NOT want "dumpable" to get set to 2 because you have the
     privilege escalation vulnerability
<snip]

Is it that something else is misbehaving and trying to dump core as root?
