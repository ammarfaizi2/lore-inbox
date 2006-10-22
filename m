Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWJVT6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWJVT6O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 15:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWJVT6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 15:58:14 -0400
Received: from web55607.mail.re4.yahoo.com ([206.190.58.231]:15536 "HELO
	web55607.mail.re4.yahoo.com") by vger.kernel.org with SMTP
	id S1751233AbWJVT6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 15:58:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=DTG0pn7prCEHGHerAtjOkbznCKewX2rKnf7O1BQn63ux5JzZ7AvQslpyevmGB0303p4vBHZtuzLyKp8oIWu+0sUffcOMfdsDZVUrgrCAlOHfJSFCz78+53g4Q3k4f3wBtP0EXruvO40e6KyN+KBN9rVenu1prj+P2xGj9BLJeQg=  ;
Message-ID: <20061022195809.30126.qmail@web55607.mail.re4.yahoo.com>
Date: Sun, 22 Oct 2006 12:58:08 -0700 (PDT)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Hopefully, kmalloc() will always succeed, but if it doesn't then....
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

Hopefully, kmalloc() should always succeed. But if it doesn't then the kernel is going to crash
left and right. But I guess that there's no point in running if there is no memory. Anyways, here
is what I found at many places:

func()
{
   char *a; 
   char *b;

   a = kmalloc(10, GFP_KERNEL);
   if (!a)
       goto error;

   b = kmalloc(10, GFP_KERNEL);
   if (!b)
       goto error;

 error:
  kfree(a);
  kfree(b);

}

So, if memory allocation to 'a' fails, it is going to kfree 'b'. But since 'b' is not initialized,
 kfree may crash (unless DEBUG is defined).

I have seen the same case at many places when allocating in a loop.

Regards,
Amit 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
