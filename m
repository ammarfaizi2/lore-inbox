Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWDSXv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWDSXv3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 19:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWDSXv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 19:51:29 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:54237 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S1751284AbWDSXv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 19:51:28 -0400
Message-ID: <4446CCD8.1020608@novell.com>
Date: Wed, 19 Apr 2006 16:50:48 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Seth Arnold <seth.arnold@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 4/11] security: AppArmor - Core access controls
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com> <1145470230.3085.84.camel@laptopd505.fenrus.org> <44468817.5060106@novell.com> <Pine.LNX.4.63.0604191904370.11063@cuia.boston.redhat.com> <20060419231831.GE13761@suse.de> <Pine.LNX.4.63.0604191920290.11063@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0604191920290.11063@cuia.boston.redhat.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Wed, 19 Apr 2006, Seth Arnold wrote:
>   
>> On Wed, Apr 19, 2006 at 07:05:08PM -0400, Rik van Riel wrote:
>>     
>>> Are confined processes always restricted from starting
>>> non-confined processes?
>>>       
>> It is specified in policy via an unconstrained execution flag: 'ux'. Any 
>> unconfined children can of course do whatever they wish.
>>     
> And the default is for the children to inherit the security
> policy from the parent process, like in SELinux ?
>
> How do apparmor and selinux differ in how they contain bad
> things?
>   
To be able to execute any child, the confined process must have explicit
permission to execute it:

    * "/bin/foo px" says that the child will execute with its own
      policy. The policy must exist, or access is denied. This is useful
      if, say, xinetd wants to exec Sendmail.
    * "/bin/foo ix" says that the child will execute with its parent's
      policy, "inherit". This is useful if, say, a shell script wants to
      exec cp.
    * "/bin/foo ux" says that the child will exec with no confinement at
      all. This should be used carefully, say, if sshd wants to exec
      bash to allow an administrator to have an unconfined shell.

You can also say something like "/bin/** ix" which would let you run
anything in /bin, but all subject to the parent's policy. You could say
"/bin/** px" but that would mostly cause exec() failures except to the
extent that policies exist. You could say "/bin/** ux" but that would
not be wise :)

Crispin
-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com

