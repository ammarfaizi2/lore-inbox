Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbTDQFef (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbTDQFef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:34:35 -0400
Received: from NS5.Sony.CO.JP ([137.153.0.45]:26824 "EHLO ns5.sony.co.jp")
	by vger.kernel.org with ESMTP id S263068AbTDQFee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:34:34 -0400
Message-ID: <3E9E3FA9.6060509@sm.sony.co.jp>
Date: Thu, 17 Apr 2003 14:46:17 +0900
From: Yusuf Wilajati Purna <purna@sm.sony.co.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk
CC: purna@sm.sony.co.jp
Subject: Re: 2.4+ptrace exploit fix breaks root's ability to strace
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2003-03-22 17:28:54, Arjan van de Ven wrote:
>On Sat, Mar 22, 2003 at 05:13:12PM +0000, Russell King wrote:
>> 
>> int ptrace_check_attach(struct task_struct *child, int kill)
>> {
>> 	...
>> +       if (!is_dumpable(child))
>> +               return -EPERM;
>> }
>> 
>> So, we went from being able to ptrace daemons as root, to being able to
>> attach daemons and then being unable to do anything with them, even if
>> you're root (or have the CAP_SYS_PTRACE capability).  I think this
>> behaviour is getting on for being described as "insane" 8) and is
>> clearly wrong.
>
>ok it seems this check is too strong. It *has* to check
>child->task_dumpable and return -EPERM, but child->mm->dumpable is not
>needed.

So, do you mean that the following is enough:

int ptrace_check_attach(struct task_struct *child, int kill)
{
      ...
+       if (!child->task_dumpable)
+               return -EPERM;
}

Regards,

Purna
         		


