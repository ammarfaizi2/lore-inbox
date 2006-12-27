Return-Path: <linux-kernel-owner+w=401wt.eu-S1751728AbWL0SgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbWL0SgY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 13:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWL0SgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 13:36:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:40651 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbWL0SgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 13:36:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oMc3dgwMg4ZuLwRxL1rw5O0No2uSDwa5XNmYbe5j7w5h83uDbHEXQCv7T1Yu8wfKKGdODpQzQFvtiaDItqWEVRgEbOzPWKer5JoppGD10M8m5XUNOVjd8J24v/HVzmt3dlqbub/Tv+dbkK8OF00hzNEKwCpsADOsjMap447HMPw=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: ray-gmail@madrabbit.org
Subject: Re: Feature request: exec self for NOMMU.
Date: Wed, 27 Dec 2006 19:35:07 +0100
User-Agent: KMail/1.8.2
Cc: "Rob Landley" <rob@landley.net>, linux-kernel@vger.kernel.org,
       "David McCullough" <david_mccullough@au.securecomputing.com>
References: <200612261823.07927.rob@landley.net> <2c0942db0612262113v5b504aecmdd922193415b60de@mail.gmail.com>
In-Reply-To: <2c0942db0612262113v5b504aecmdd922193415b60de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612271935.07835.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 December 2006 06:13, Ray Lee wrote:
> On 12/26/06, Rob Landley <rob@landley.net> wrote:
> > I'm trying to make some nommu-friendly busybox-like tools, which means using
> > vfork() instead of fork().  This means that after I fork I have to exec in
> > the child to unblock the parent, and if I want to exec my current executable
> > I have to find out where it lives so I can feed the path to exec().  This is
> > nontrivial.
> >
> > Worse, it's not always possible.  If chroot() has happened since the program
> > started, there may not _be_ a path to my current executable available from
> > this process's current or root directories.
> 
> How about openning an fd to yourself at the beginning of execution, then calling
> fexecve later?

This solves chroot problem. How to find path-to-yourself reliably
(for one, without using /proc/self/exe) is not obvious to me.
--
vda
