Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVG1PNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVG1PNM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVG1PLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:11:10 -0400
Received: from [194.90.237.34] ([194.90.237.34]:4401 "EHLO mtlex01.yok.mtl.com")
	by vger.kernel.org with ESMTP id S261555AbVG1PJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:09:33 -0400
Date: Thu, 28 Jul 2005 17:53:53 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: linux-kernel@vger.kernel.org
Subject: kernel guide to space (updated)
Message-ID: <20050728145353.GL11644@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been tasked with edicating some new hires on linux kernel coding style.
> While we have Documentation/CodingStyle, it skips detail that is supposed to
> be learned by example.
> 
> Since I've been burned by this a couple of times myself till I learned,
> I've put together a short list of rules complementing
> Documentation/CodingStyle. This list is attached, below.

Here's an updated version of the boring list.
My thanks to everyone who commented on the first draft.

---

kernel guide to space AKA a boring list of rules
http://www.mellanox.com/mst/boring.txt

This text deals mostly with whitespace issues, hence the name.

Whitespace -- In computer science, a whitespace (or a whitespace character) is
any character which does not display itself but does take up space.
	From Wikipedia, the free encyclopedia.

1. Read Documentation/CodingStyle. Yes, it applies to you.
   When working on a specific driver/subsystem, try to follow
   the style of the surrounding codebase.

2. The last character on a line is never a whitespace
		Get a decent editor and don't leave whitespace at the end of
		lines.
			Documentation/CodingStyle

Whitespace issues:

3. Space rules for C

3a. Binary operators
	+ - / * %
	== !=  > < >= <= && ||
	& | ^ << >>
	= *= /= %= += -= <<= >>= &= ^= |=

	spaces around the operator
	a + b

3b. Unary operators
	! ~
	+ - *
	&

	no space between operator and operand
	*a

3c. * in types
	space between type name and *
	multiple * dont need additional space between them
	no space between * and its operand

	struct foo **bar;

3d. Conditional
	?:
	spaces around both ? and :
	a ? b : c

3e. sizeof
	space after the operator
	no space if the operand is in barces
	sizeof *a
	sizeof(b)

3f. Braces etc
	() [] -> .

	no space around any of these (but see 3h)
	foo(bar)

3g. Comma
	,
	space after comma, no space before comma
	foo, bar

3h. Semicolon
	;
	space after semicolon (e.g. in a for loop)
	no space before semicolon
	for (i = 0; i < 10; ++i)
		foo;

3i. if/else/do/while/for/switch
	space between if/else/do/while and following/preceeding
	statements/expressions, if any

	if (a) {
	} else {
	}

	do {
	} while (b);

3j. return
	space between return and following expression,
	even if the operand is in barces
	return (a);

3k. Labels
	goto and case labels should have a line of their own (possibly
	with a comment)
	no space before colon in labels

int foobar()
{
	...
foolabel: /* short comment */
	foo();
}

4. Indentation rules for C
	Use tabs, not spaces, for indentation. Tabs are 8 characters wide.

4a. Labels
	case labels should be indented same as the switch statement.
	statements occurring after a case label are indented by one level.

	switch (foo) {
	case foo:
		bar();
	default:
		break;
	}

4b. Global scope
	Functions, type definitions/declarations, defines, global
	variables etc are global scope. Start them at the first
	character in a line (indent level 0).

static struct foo *foo_bar(struct foo *first, struct bar *second,
			   struct foobar* thirsd);

4c. Breaking long lines
		Descendants are always substantially shorter than the parent
		and are placed substantially to the right.
			Documentation/CodingStyle

	Descendant must be indented at least to the level of the innermost
	compound expression in the parent. All descendants at the same level
	are indented the same.
				if (foobar(..................................) +
				    raboof(................................) *
				    barfoo(..........................)) {
				}

5. Blank lines
	One blank line between functions.

void foo()
{
}

/* comment */
void bar()
{
}

	No more than one blank line in a row.
	Last (or first) line in a file is never blank.
	Files end with a newline. gcc warns if this is not so.

Non-whitespace issues:

6. One-line statement does not need a {} block, so dont put it into one
	if (foo)
		bar;

7. Comments
	Don't use C99 // comments.

8. Return codes
	Functions that return success/failure status, should use 0 for success,
	a negative value for failure.
	Error codes are in linux/errno.h .

	if (do_something()) {
		handle_error();
		return -EINVAL;
	}

	Functions that test a condition return 1 if condition is satisfied,
	0 if its not.

	if (is_condition())
		condition_true();

9. Data types
	Standard linux types are in linux/types.h .
	See also Linux Device Drivers, Third Edition,
	Chapter 11: Data Types in the Kernel.  http://lwn.net/images/pdf/LDD3/

9a. Integer types
	int is the default integer type.
	Use unsigned type if you perform bit operations (<<,>>,&,|,~).
	Use unsigned long if you have to fit a pointer into integer.
	long long is at least 64 bit wide on all platforms.
	char is for ASCII characters and strings.
	Use u8,u16,u32,u64 ... etc if you need an integer of a specific size.

9b. typedef
	Using typedefs to hide the data type is generally discouraged.
	typedefs to function types are ok, since these can get very long.

typedef struct foo *foo_bar_handler(struct foo *first, struct bar *second,
				    struct foobar *thirsd);

Editor configuration:

9. The following is helpful with VIM
	set cinoptions=(0:0

Michael S. Tsirkin

-- 
MST
