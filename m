Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVKJHkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVKJHkh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 02:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVKJHkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 02:40:37 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:10925
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751265AbVKJHkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 02:40:36 -0500
Message-Id: <437307BC.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 10 Nov 2005 08:41:32 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/39] NLKD - early/late CPU up/down notification
References: <43720DAE.76F0.0078.0@novell.com>  <43720E2E.76F0.0078.0@novell.com>  <43720E72.76F0.0078.0@novell.com>  <43720EAF.76F0.0078.0@novell.com>  <20051109164544.GB32068@kroah.com>  <43723B57.76F0.0078.0@novell.com> <20051109171919.GA32761@kroah.com>
In-Reply-To: <20051109171919.GA32761@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Greg KH <greg@kroah.com> 09.11.05 18:19:19 >>>
>On Wed, Nov 09, 2005 at 06:09:27PM +0100, Jan Beulich wrote:
>> >>> Greg KH <greg@kroah.com> 09.11.05 17:45:44 >>>
>> >#ifdef in the .h file is not needed.  Please fix your email client
to
>> >send patches properly.
>> 
>> It's not needed, sure, but by having it there I just wanted to make
>> clear that this is something that never can be called from a module
>> (after all, why should one find out at modpost time (and maybe even
miss
>> the message since there are so many past eventual symbol resolution
>> warnings) when one can already at compile time.
>
>If it isn't present, and you do a build, you will still get the error
at
>build time, just during a different part of it.  Adding #ifdef just
to
>move the error to a different part of the build isn't needed. 
Remember,
>we want to not use #ifdef at all if we can ever help it.

I understand that. But you don't see my point, so I'll try to explain
the background: When discovering the reason for the kallsyms change
(also posted with the other NLKD patches) not functioning with
CONFIG_MODVERSIONS and binutils between 2.16.90 and 2.16.91.0.3 I
realized that the warning messages from the modpost build stage are very
easy to overlook (in fact, all reporters of the problem overlooked them
as well as I did on the first build attempting to reproduce the
problem). This basically means these messages are almost useless, and
detection of the problem will likely be deferred to the first attempt to
load an offending module (which, as in the case named, may lead to an
unusable kernel). Hence, at least until this build problem gets
addressed I continue to believe that adding the preprocessor conditional
is the better way of dealing with potential issues. Sure I know that
hundreds of other symbols possibly causing the same problem aren't
protected...

Jan
