Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWGKVvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWGKVvB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWGKVvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:51:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:35479 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932148AbWGKVu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:50:58 -0400
Message-ID: <44B41D39.801@fr.ibm.com>
Date: Tue, 11 Jul 2006 23:50:49 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@gmail.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 0/7] execns syscall and user namespace
References: <20060711075051.382004000@localhost.localdomain>	 <44B3EA16.1090208@zytor.com> <44B3ED3B.3010401@fr.ibm.com>	 <44B3EDBA.4090109@zytor.com> <a36005b50607111250k70598c31nbc9c0de661dba9e6@mail.gmail.com>
In-Reply-To: <a36005b50607111250k70598c31nbc9c0de661dba9e6@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> On 7/11/06, H. Peter Anvin <hpa@zytor.com> wrote:
>> How about execveu()?  -n looked a bit weird to me, mostly because the
>> "le" form would be execlen() which looks like something completely
>> different...
> 
> I would prefer a more general parameter.  With this extension it is
> expected to have six new interfaces.  I really don't want to repeat
> this if somebody comes up with yet another nice extension.
> 
> So, how about generalizing the parameter.  Make is a 'flags'
> parameter, assign a number of bits to the unshare functionality and
> leave the rest available.  Use a 'f' suffix, perhaps.  Then in future
> more bits can be defined and, if necessary, additional parameters can
> be added depending on set flags.  The userspace prototypes can then if
> absolutely necessary be extended with an ellipsis.  Not nice but not
> as bad as adding more and more intefaces.

How's that ?

int execvef(int flags, const char *filename, char *const argv [], char
*const envp[]);

initially, flags would be :

#define EXECVEF_NEWNS	0x00000100
#define EXECVEF_NEWIPC	0x00000200
#define EXECVEF_NEWUTS	0x00000400
#define EXECVEF_NEWUSER	0x00000800

execvef() would behave like execve() if flags == 0 and would return EINVAL
if flags is invalid. unshare of a namespace can fail and usually returns
ENOMEM.

C.
