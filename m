Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312734AbSCVPxR>; Fri, 22 Mar 2002 10:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312736AbSCVPxH>; Fri, 22 Mar 2002 10:53:07 -0500
Received: from smtp3.cern.ch ([137.138.131.164]:52686 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S312734AbSCVPwt>;
	Fri, 22 Mar 2002 10:52:49 -0500
To: roms@lpg.ticalc.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: your mail, [PATCH] tipar
In-Reply-To: <E16lHKt-0007dn-00@the-village.bc.nu> <3C935F7A.AD380542@free.fr>
From: Jes Sorensen <jes@wildopensource.com>
Date: 22 Mar 2002 16:52:01 +0100
Message-ID: <d31yecd2hq.fsf@lxplus052.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Romain Liévin <rlievin@free.fr> writes:

> Hi,
> 
> according to various remarks, I improved the source code.
> I submit it again for new comments & suggestions...

Another comment. Your usage of the START macro is kinda
broken. Basically you declare it as #define START(x) but never use the
value, and instead rely on a local scope variable named max being
present.

> +/* ----- global defines -----------------------------------------------
> */
> +
> +#define START(x) { max=jiffies+HZ/(timeout/10); }
> +#define WAIT(x)  { \
> +  if (time_before((x), jiffies)) return -1; \
> +  if (current->need_resched) schedule(); }
> +/* Try to transmit a byte on the specified port (-1 if error). */
> +static int put_ti_parallel(int minor, unsigned char data)
> +{
> +       int bit;
> +       unsigned long max;
> +       
> +       for (bit=0; bit<8; bit++) {
> +               if (data & 1) {
> +                       outbyte(2, minor);
> +                       START(max); 

If you really want to use the START macro, you should redefine it as
follows:

#define START(x) { x=jiffies+HZ/(timeout/10); }

One example of where one has to be careful with macros ;(

Jes
