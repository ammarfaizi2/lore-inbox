Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbSL2WSo>; Sun, 29 Dec 2002 17:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSL2WSo>; Sun, 29 Dec 2002 17:18:44 -0500
Received: from holomorphy.com ([66.224.33.161]:40933 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261908AbSL2WSm>;
	Sun, 29 Dec 2002 17:18:42 -0500
Date: Sun, 29 Dec 2002 14:25:38 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: tabs on otherwise empty lines
Message-ID: <20021229222538.GK29422@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The <HELP> state is willing to consume config options as part of help
texts AFAICT:

(1)	[ \t]+  {
(2)	\n/[^ \t\n] {
(3)	[ \t]*\n        {
(4)	[^ \t\n].* {
(5)	<<EOF>> {

Now consider: "\tSome help text.\n\t\nconfig FOO\n\tdepends on BAR\n"

"\tSome help text." is consumed by (1).
"\n" is consumed by (3).
"\t\n" is consumed by (3) again.
"config FOO" is consumed by (4), which resets first_ts to last_ts,
	which does not actually change the value of first_ts.
"\tdepends on BAR\n" is consumed by (1), and does not zconf_endhelp()
	as the indentation level is the same as for "\tSome help text."

Better boundary detection logic is needed here.

Thanks,
Bill
