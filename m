Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266715AbUG0XMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266715AbUG0XMQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 19:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266707AbUG0XKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 19:10:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:39642 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266705AbUG0XKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 19:10:16 -0400
Date: Tue, 27 Jul 2004 15:50:11 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ryan Arnold <rsa@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: [announce][draft3] HVCS for inclusion in 2.6 tree
Message-Id: <20040727155011.77897e68.rddunlap@osdl.org>
In-Reply-To: <1090958938.14771.35.camel@localhost>
References: <1089819720.3385.66.camel@localhost>
	<16633.55727.513217.364467@cargo.ozlabs.ibm.com>
	<1090528007.3161.7.camel@localhost>
	<20040722191637.52ab515a.akpm@osdl.org>
	<1090958938.14771.35.camel@localhost>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 15:08:58 -0500 Ryan Arnold wrote:

| Ok Andrew, here is draft3 of my patch.  This patch contains fixes for
| the following items:
| 
| 
| Thanks for the kthread suggestions.  The kthread API is awesome.  My
| stress tests seem to be going very well.  So, if you don't have any more
| comments....

I do.  (this is for the first 1000 lines of the patch... more to come)

+struct hvcs_partner_info {
+	/* list management */
+	struct list_head node;
+	/* partner unit address */
+	unsigned int unit_address;
+	/*partner partition ID */
+	unsigned int partition_ID;
+	/* CLC (79 chars) + 1 Null-term char */
+	char location_code[HVCS_CLC_LENGTH + 1];
+};

Ugly comments style.  Which comment goes with which
data?  Commenting data can be very helpful, but most of these
are close to useless since they are so obvious.
And put a space after "/*".

+/* Convert arch specific return codes into relevant errnos.  The hvcs
+ * functions aren't performance sensitive, so this conversion isn't an
+ * issue. */

Long-comment style is
/*
 * line1
 * line2
 * lineN
 */
(in multiple places).


+int hvcs_convert(long to_convert)
+{
+	switch (to_convert) {
+		case H_Success:
+			return 0;
+		case H_Parameter:
+			return -EINVAL;
+		case H_Hardware:
+			return -EIO;
+		case H_Busy:

Can these H_values be converted from that coding style?

+/* Helper function for hvcs_get_partner_info */
+int hvcs_next_partner(unsigned int unit_address, unsigned long last_p_partition_ID, unsigned long last_p_unit_address, unsigned long *pi_buff)

Split the function line. (multiple places)

+	memset(pi_buff,0x00,PAGE_SIZE);

Use spaces after commas.


+		/* This is a very small struct and will be freed soon */
+		next_partner_info = kmalloc(sizeof(struct hvcs_partner_info),
+				GFP_ATOMIC);

Where is it freed?

+	  will depend on arch specific apis exported from hvcserver.ko

"APIs"

+	  To compile this driver as a module, choose M here: the
+	  module will be called hvcs.ko.  Additionally, this module
+	  will depend on arch specific apis exported from hvcserver.ko
+	  which will also be compiled when this driver is built as a
+	  module.
+
 config PC9800_OLDLP

This patch segment won't apply since PC9800 has been removed.

+#define __ALIGNED__	__attribute__((__aligned__(8)))

Why aligned? why 8?  (just curious)  Could use a comment if it's important.



+			 * we commited to delivering it.  But don't try to wake
+			 * a non-existant tty. */

				non-existent


+	/* remove the read masks*/
			   masks */

+		for (i=0;got && i<got;i++)

	add spaces for readability:
		for (i = 0; got && i < got; i++)

+	if (!got){
	if (!got) {



--
~Randy
