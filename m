Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264653AbTAELQh>; Sun, 5 Jan 2003 06:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264659AbTAELQh>; Sun, 5 Jan 2003 06:16:37 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:50390 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S264653AbTAELQf>; Sun, 5 Jan 2003 06:16:35 -0500
Date: Mon, 06 Jan 2003 00:24:32 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Paul Jakma <paul@clubi.ie>, "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: Honest does not pay here ...
Message-ID: <2082330000.1041765872@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0301050314470.16362-100000@fogarty.jakma.org>
References: <Pine.LNX.4.44.0301050314470.16362-100000@fogarty.jakma.org>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is another thread going on that seems to make this clear, the one
where Rusty Russell and Linus are discussing the implementation of the
module license enforcement mechanism.  The policy in Rusty's code is
identical to the 1995 posting.  So obviously they don't think it has
changed.

And frankly, courts in most parts of the world will look at community
practice as a (slightly weaker than a court case) precedent for what is
expected.  Here we have seven years of precedent, including at least two
implementations of a mechanism that implemented the policy on
the kernel side, and many widely used binary-only-with-wrapper modules
(NVidia, winmodems, etc.).

I really think the issue was decided in 95 and cemented by time.

Andrew

Some extracts from the patch (the latter two conspire to enforce no linking
to gpl-only functions from incompatibly licensed modules):

...

+/*
+ * The following license idents are currently accepted as indicating free
+ * software modules
+ *
+ *	"GPL"				[GNU Public License v2 or later]
+ *	"GPL v2"			[GNU Public License v2]
+ *	"GPL and additional rights"	[GNU Public License v2 rights and more]
+ *	"Dual BSD/GPL"			[GNU Public License v2
+ *					 or BSD license choice]
+ *	"Dual MPL/GPL"			[GNU Public License v2
+ *					 or Mozilla license choice]
+ *
+ * The following other idents are available
+ *
+ *	"Proprietary"			[Non free products]
+ *
+ * There are dual licensed components, but when running with Linux it is 
the
+ * GPL that is relevant so this is a non issue. Similarly LGPL linked with 
GPL
+ * is a GPL combined work.
+ *
+ * This exists for several reasons
+ * 1.	So modinfo can show license info for users wanting to vet their 
setup
+ *	is free
+ * 2.	So the community can ignore bug reports including proprietary modules
+ * 3.	So vendors can do likewise based on their own policies
+ */

...

+#define EXPORT_SYMBOL_GPL(sym)				\
+	const struct kernel_symbol __ksymtab_##sym	\
+	__attribute__((section("__gpl_ksymtab")))	\
+	= { (unsigned long)&sym, #sym }

...

 	list_for_each_entry(ks, &symbols, list) {
  		unsigned int i;

+		if (ks->gplonly && !gplok)
+			continue;

...

--On Sunday, January 05, 2003 03:21:22 +0000 Paul Jakma <paul@clubi.ie> 
wrote:

> On Sat, 4 Jan 2003, Adam J. Richter wrote:
>
>> 	Andre has informed me of a posting made by Linus to the
>> gnu.misc.discuss newsgroup (Message-ID
>> "4b0rbb$5iu@klaava.helsinki.fi") on December 17, 1995 where he
>> basically gave his permission for the EXPORT_SYMBOL
>> vs. EXPORT_SYMBOL_GPL system hereby proprietary modules that call only
>> EXPORT_SYMBOL symbols are allowed:
>>
>> http://groups.google.com/groups?as_umsgid=4b0rbb%245iu%40klaava.helsinki
>> .fi
>
> Why not formalise this in the Linux COPYING file?
>
> It would make things clear, would help people like Andre and
> corporations like NVidia to continue to bring drivers to linux. Not a
> single person who matters (ie actual kernel contributors) has so far
> expressed any opinion (eg in the rash of GPL threads currently
> ongoing) that would indicate they are not happy with the current
> status quo as detailed in the above post by Linus.
>
> If EXPORT_SYMBOL kernel functions are LGPL (bar the
> EXPORT_SYMBOL_GPL) formalise it in .../COPYING. (and peace can reign
> on l-k once again :) ).
>
> regards,
> --
> Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
> 	warning: do not ever send email to spam@dishone.st
> Fortune:
> Census Taker to Housewife:
> Did you ever have the measles, and, if so, how many?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


