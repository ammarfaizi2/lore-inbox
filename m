Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbVHPU5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVHPU5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 16:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbVHPU5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 16:57:13 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:43279 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932451AbVHPU5M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 16:57:12 -0400
Message-ID: <4302530E.4030107@vmware.com>
Date: Tue, 16 Aug 2005 13:56:46 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       virtualization@lists.osdl.org, Pratap Subrahmanyam <pratap@vmware.com>
Subject: Re: [PATCH 3/6] i386 virtualization - Make ldt a desc struct
References: <200508161306_MC3-1-A75D-6646@compuserve.com> <430233FF.7090106@vmware.com> <20050816204149.GN7991@shell0.pdx.osdl.net>
In-Reply-To: <20050816204149.GN7991@shell0.pdx.osdl.net>
Content-Type: multipart/mixed;
 boundary="------------090609050908020704000801"
X-OriginalArrivalTime: 16 Aug 2005 20:56:26.0117 (UTC) FILETIME=[F7885350:01C5A2A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090609050908020704000801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chris Wright wrote:

>* Zachary Amsden (zach@vmware.com) wrote:
>  
>
>>Several reviewers noticed that initialization and destruction of the
>>mm->context is unnecessary, since the entire MM struct is zeroed on
>>allocation anyways.
>>    
>>
>
>well, on fork it should be just shallow copied rather than zeroed.
>  
>

Right you are.  That turned out to be a really bad idea (TM).  Updated 
my ldt test and got the expected panic with the BUG_ON left in.

Zach

--------------090609050908020704000801
Content-Type: image/gif;
 name="bobo.gif"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="bobo.gif"

R0lGODdh0AKQAfcAAAAAAKqqqkNDQ0hISIuLi3p6ekJCQlRUVHFxcT09PSgoKAQEBIKCgsbG
xsXFxV9fXxwcHM7OztfX16GhoX19fZqammJiYhYWFouLi7S0tLCwsEFBQczMzJmZmYSEhCAg
IG5ubtTU1G5ubmFhYTU1NWJiYjc3NyQkJJWVlbKysqCgoHV1daSkpLm5uR8fHzY2NoeHhzo6
OiUlJQQEBHR0dK2trYaGhmxsbERERAkJCQMDAwEBAXd3d6+vry4uLkBAQLq6ulxcXA8PDxAQ
EJiYmIuLiwoKCjc3N2VlZZWVlYmJiWNjY0dHR7GxsYGBgVdXVxISEgYGBgICAj4+Pjg4OC4u
Lh8fHwAAAISEhLq6uoeHh25ubnJycm1tbR0dHYWFhZSUlIWFhaurq1JSUkJCQgQEBCAgIJWV
lS0tLRAQEAYGBmZmZnt7ewgICCIiInh4eDQ0NAoKCg4ODqmpqcbGxoCAgE9PT2lpaTY2NjMz
M7W1tc7OzhISEmdnZwYGBrGxsTIyMg4ODmJiYiYmJggICCAgIJ2dndra2tnZ2aurqyMjI05O
ThgYGGxsbHp6en9/f19fX1JSUmNjYw0NDSQkJCcnJwEBAV1dXfX19f///7+/vyYmJlRUVFdX
Vzk5OaGhoRgYGBgYGAoKCmpqalNTUwoKCoCAgLGxsZaWljc3N1FRUQMDAxISEioqKg8PD3p6
egEBAXV1dXBwcBsbGzExMRMTExERERAQEBISEm9vb2VlZXx8fHR0dIaGhpWVlSQkJBYWFl9f
X7a2toSEhG9vbxMTE0RERB4eHiUlJTAwMIGBgY+Pj3BwcE9PTz8/Pw8PDxcXF0xMTD8/PxgY
GA0NDRAQEBERERISEhQUFAcHBwcHBwcHB2NjYywsLBEREQsLCwAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACwAAAAA0AKQAQAI/gABCBxIsKDBgwgTKlzIsKHD
hxAjSpxIsaLFixgzatzIsaPHjyBDihxJsqTJkyhTqlzJsqXLlzBjypxJs6bNjgFyFszJ06DO
gz8X8gwKYGgAjD0FGg1qlGDTgU+VDnU61WJSilcbRi1aVWhXrlm3iv26VepRqF+xEh0bNi1Q
oh7Lcn17FixZuAnlRsxqty7Dq0v98tV7ka9ZvHTX3jV8M6ROpnUV+0U7+S1aqZcLR96MuTPk
znNDh/6sVvRExAhJk87LWfRP1a1hZ6Y6GzXE1a9jt1ZoG+lusKl3f+4Nmjjvo7grs67NOXnc
yquDZ5YNurHI19IP+2S8U/fsiqhz/k/3Xn38971nlT80nj26Zc/kR8cXX97179LFlSM2zh6/
/fDqqfbXfbelx9x6AcZ2IE7qnedVfhBap9FYD9JGm2TO2TfgYNzRJ5959X0YYndtJSbYYpO5
FaFp74nooocwpvdbV+6ZSKJw0CVIGYY3NkgVYPfhpaKG2wHpYJGKbceckB0SWCOSJ7YF4I9T
EvmkhBLBtp9hSRL533AsKgnhlpcht5mRZlJZZpjdjQcXdRqS2SaVPu7Y3IdpzpXnY3jGeSdx
zoH5Zo4Z6oljhX0O2qacds2ZaJ1apohcmEky6hZhFr7YXI6Z8mjnmv1heVx2y2Xal4edylgU
m6aCaCqf/jFiluecsEKqY4+5RRUjh44C6t2ek4oH7KrCiiiore8d2yqtS4EYKpu1OurieUxa
Niup0sr6ZXzUcjrikYG5ymK4Ysp2rain3VrqkV6muiK24o47n6ohxjpqi+DeSl+X7t6raYRw
2msvq/mueGW8ztaZ7bumoUqpt70iiy/A9E77sJgE16uvkwoLTCC6BcKL8YhPBiwxs9mazDB8
7LJb7cgW7vvxwRS76rHN9BYq8r8sV1ilw4j2+53DLy/b7sQOUgdnfUX7inTPjJaqMsj+1ehe
lVbOi6jMKWudNc5bcww21BVPve7NPfOs9KH+cl1z2gO7nfHX5XWp6MJmk2o1/nlLXxxx2Abn
7PXUNFPtFZBMSskhZIpHyR5bDROKoeOU06kVjVyiWDll8uk6ZI+Wfyr6YZubte3lUp5OOuOT
h0466q3beWbkN0Lp+nGISx7lf7SrCfqGsb+++pnB93W74cgnr/zyzDfv/PPQRy/99NRXb/31
2Gev/fbcd+/99+CHL/745Jdv/vnop6/++uy37/778Mcv//z012///eovHmruqR+fbunGG10A
hUdA8BSPLQfUnGYUVkAE6oeBE9oSd3Y2ksbdriz6A2CWLvXA3xVwQAvEllwsKMCWce8xbLvc
ggy1QgMuiHCD+xh6XhjDsRVuVPypYd2e5RuM9WeC/tdhm9lQSEMTtm13JOrXDU3nwsS1MHAM
A+L2sLOydf1tVVWcYRXlBEMjqnCLHaQbz9KlFBDCLYzaOYnTgLcSnRXMM+2RoRm/VLsnfst3
+JEU1lyGxkZN8S4+JB6S9AaxHOrPjpbS4dwGmMajQUuIXsMdv/AoxkRGTooNRJEIAZlATDLS
j47E2hpv6Llu4atkgrwQAymkpD0OyZI8VF6kFuU3WaGRg5gM1J8kdcpgqWpY5wpkmXa5MNoB
81GAA+XImvVBzEHxiFAsGt0yVDhdgoqXdVTmjq6ZzGgZbVCHFOYiZxkzPZ5IXuDk1vX2qC3W
qVNe4rQi2K4VNT0h055r/kRZO88JM2/605dB++YryxZGcj1Lgs7snexk9JR6BvSMxOInIX0G
UH9dCJ7LnBnxNppPvDFTn+yED6aiF9K1xUuaWXxjoRzaxTs+8pkvvWLenua3n2k0nl8s5hiN
iMqQlSuF+RylHDVmyoyqtGJG02lvbEqyProUeiXlmzpR6shixg2pb1TbUGNKTae+bac0fRlT
iXpFhziUbDS14yIF+swc8pSgDz1a1HpqsaeGNKlysyrEsOfGaU51ryl9W1dtqMigCq6IEK0k
XKHJNKy2VWyBVWzCxia0gU10jGgLZSQve7U+tvSsZV0qJB+bNAg6z3OJkwzvJqnNTwYnde5c
/ujwBOhA2O0utrM91UYv+DnX4ZKOvM0cbg/XSXcOd5uZ9CTkhkuuAeKyeKwh4epkR9vFoLNj
mAPQcXuy3efi77vgDa94x0ve8pr3vOhNr3rXy972uve98I2vfOdL3/ra9774za9+98vf/vr3
hJ4EThJta9r/GvjACDYc0Hb2w5Em+MEQjjBN1mJWr6bGniiJpYQ3zOH9atfCBz2n4jzoWg13
+MQojm9HyVrhJDZtsymOsYz9+2HAPrVVu0Klg2fM4x67l4s2XmtRy5lVHxv5yPKlcF1BCy+x
3lSeSI6ylO3nNqoKeYc/RSxGp8zlLsfPup5CLhsbybnuBtjLaE6z/prXzOY2u/nNcI6znOdM
5zrb+c54zrOe98znPvv5z4CWXm+BB9jaDljAvjExolVSYLoUKJcf3aByFRjoSvcQymVd9EwV
mtO0djrDjfZ0pltk4mrC2NKoRhCmQ1siFg+t0bZR9JUZdOmchrhqJ7Nsqnc9x64ZCctqDbM2
VXRX2w3Tt1t1LgJJTDSJ6jo/sV5sS2fNa1TX01xbxqfjVMltmLn6ssDJrGGT6qXh7NWbLPR2
TLV9bOqyu9rwhrKV0V0dek8WZ01St7rlViy3Iq2UicHVPn80sRGK+JJSq2i8F87Whmebrqiq
MoghyCutRhR1/VzsII1ab5Q2O9MTfDbD/uHtyltiE4xpM5Zji73JxNrbohi9EhGlFZ3M6bOx
r26QyEfO62hr+W5fzavEdTrO0WbNwTUfVrnfyepsgzWaJvcizwM90Oo2brdWV53pZD5pxEG7
Uqv8bZmxLmBD6syJZgdqBqfO9ra7/e1wj7vc5w6TwISa7njPu973zve++/3vgA88nAdN3EJT
mnOkjnR0785EdB2U0YTPeVWau3jTStB/gk+yj8aN+KBvqkgrFK1VGN9Gy5Me1xjPKucPB25Z
Zx68Pk+mMuk6mmzSXOend711dK/ForNW1KTMd2Rfr152AvzhT36p8dUlSRGXztSaBjMSRxfp
Ukr31ZTteK8J/jtkMS+R+Oe99q+Qf3HvV/ysTA79zDcNerRJM+msVjr5ZzXzV+kFln7KeJyo
DX7xUpVM51Ip65ZaFfdvYZcs0qZwCZdbQAN0vpZQOpYU9MYYsVdkEzhXcBVM/cde4pd4t6d6
m3dy+0Zxd3MzGuhRCOhtNodXCeJZM8Jkv7dlqsVxfbWB61VyHmh/IAhzxXZr93ZPMMdVQeZ0
LFdL7UKBuLcsL0ZwNJhCNtheFThT/HJVPGhhdmV0kQJp4tSAzuZ8MKVWlRVMUyhRLGZuTQiG
Txh+wsdIDkR2yvZhStiCYed1WpdukmRszXR9jfeGumNb6pddDlh4f+h1x5WGhkg1/rx3iIrI
Zwu2iI74ZnanFon4iJRYiZZ4iZiYiZq4iZx4g2dmIw/oVZMzg7CDIENoivtjTnpUYWeWThrU
idUmeoy1h521inzkaT5IbrY2h2GoajfWak8Hi6lWgWeTSu+iSUVGdLm4EcE3hjeGhmImWcJI
csynbN1nTR+ob03FirZYQgqla85YdJ6XjcE4jZXWgSwTgAeXVx0HiOh3gO8XJOv4eR8ILMRG
TLaUcZOngOZobTYGgPPXOWkRe7TnRVxIJ8Y1cJ2ng/LngBdohUDYj/5YcFGngzinjBqXjClI
jr2Ucx2ZWMCGcNq4cxLpZziIU9/4j0koV9W4kRbZcu34/pGYVUjTR24kWZKMuJLSiH0X+ZKW
RYxxxHFzg40+mYA5aIe3OHw4iWdVl1yj6I3u6IastHGsJ2w7Zo1fZ2aPk1DbYowftJRgGZZi
OZZkWZZmeZZomZZquZZs2ZZu+ZbWE3mVh2wFhkFOxI2miBSQ13XgxI3Y9UCfCJcRJovF+IWy
B4BkqI2itn0kAX1jgl0GSZOCaWRAeZRCo0U/g5E+5UKg9lYvNEf+dpmTKWPL92tGOJBryHJF
SEk79lEotG3DdG6FtVXi5pXfN5oPho4RCU8sRTleqVcqVIMqWH886ZAKR5zM9DnKko/t9m64
SZoqaS2cdkYFaJjDaUbCiYJ1/phj/VaTo8aQIjlZJ/icG6abvZhl07KEd5R+ILmV19k7xumR
4NY18vmDk0ie9HWSMrUxIHmeYQWZS/dpNcVP8RmT81la9YlWz4ifBhaFs3lvg5VFlYmeVdVK
kGU3uUaPHFmGGqpyUsegDZqah9dcy8VQ7hiNTbWV9CeXiPZbhfhaKzVifjmIrwiiNsoR93mj
Omo+ObqjPloTkciMgfmjRFqkRnqkSJqkSnqJLAqKOHaPvaSHi5eXmuEY73h6kiZrV3mVc7mk
4kOY8wmMfXloQxSCm8mZIAFaPVqYZORSt/mdXvpHqxaG4UhmrdWfEzqnM8FDa3qgvjiUyean
cao9/qXpRnWKnCcIji0Jo5jnaLFJZHbaWJLjh7Ykm5QFSGRVpqbZp4PaGLrZnfXooSk3ewa3
mHb4fSX4TvPGS6HZNwJohhnFQdzEnF8znp1aPf/XQep4Ubmyj/c3cYrZniR4c9w5gpA6i9z5
S+H5lSHpnNEnnZx6q0DqVJZUlMb6NKuKnU5YhYK1ci54hVqmfQY6qjzZQsAomtK6TsxXreWa
rdgqgroorC12rEMHnAgTTx9nrhjqp0mXmEqZrqelk1LYhdeqWZpJUdD4pO2oqt8qjl/VeivK
oUdZf+wHsNPTlGyoOW5opyeKonC4IXV4hye1isJGqrbqlHMYoyvaYJsq/pVNarHPGa0wO7Mt
IbM0G5ZBCjI5G3A327M++7NAG7RCO7R1N6T+44qNipAmypfeY7TeWIUkCGmlSrToA6aWKaYZ
+a7QaLMTRnqoCnageTKOSrU8qpNsSqoaSXTlGqzUo2hLhKkACqhTSrZl22RcWaADeK52S0Ee
9JqPSn1mkrIadHjtqnGIirAupyNcS7cS8qnKGp/0hITuZq9qGzgrO5MnW6YBCp6wqikOWn6n
CnCLy7ieGp2tFJCJtIbfYmW4okMRimkmlVunopC06Jpm+5AJx6Wki6vUWpGFu5H6WbCr1psJ
63D8Zqb6uq7V2K/yhqW7yzzB+0R1CqnRm5RB/vhtmyugfmVC06u6xDuu7/m84PO5/ZmS3aqv
adWqyad+f+p+24qvGvh77EqxkCW+34OxhjZdKEtwhci6kYda5oSHLJq/4baxMLqtvmp6LQuV
Tmu/DvzAEBzBRLqzElzBFnzBGJzBGpyWL0ti30bAjMmoP0Z4JAqlhDZ6UrrBFYS8Z7totZt9
uKOLoxs+jjlqWrig+/mhKpwReUqnARxsKXuwHEibvnuncLqL/7rDtRaK0tuweaso/iu4yNai
REzF0Xd9BDy145i3zUmshnu3WavEadq75rGr+phOOfiOYUtaFUqv6/egO6l9EZuQCrlgyxm6
ZbybYvwRuQqt8Cqu/k9sXKIYt+d5k4n7sLKFvbPrrCH3uEsLuctqUBX1cntMa/qHkhh4VIrM
nlysoA67N/cabYQik6RIoR53cqVcrW9ayRsEkzbsxECGvavZyaL6yfVrx2KLoMm7gD1ZS6lc
kavMymfadCxJyka5bqsbt1RYjm68hXBcw527abQXzXAszM8hSoRrux2bXNfFRypaXL55wpGa
xdn8v2BsdaklzkuHxR1szQe2YqbqzgBrtXwrzzCLmlf3ms5rz/zcz/78zwAd0O/VzgxMkcIV
XCyrwCFkQHUpl2unziEs0PfLwmF6lyvzujSzjK2spaYXmSj50WMr0V9qthCLxoj0vtMZ/q+V
6zOj1765DHzJRtAiDVXLe84Od4QLfMlsS2ZbCpjmRqAiOG2we8xEiIwz/TyOS7sfzEnhjKKK
bKEJi5pLkn+hSs34HHVzbKm9fNTL08enG4iAzI5py7rNDK7EzDoCx8jTe40KKLnePMNczcdk
jMmwfFhaS7m83Ma6XFUmfIxrDch+7cTHGteypLyWicyxK7ys4m/Zudc9FY8JOs2SuZBre6+E
rbMCC2OZ7Mn+STCMjdLaydeO1XQYPdpE+bt1ddmYjc3sHJVZh9a8JcJVacBUCbhjmnY0mrRT
nJUue7Kq/dvAHdzC3T4UPNzGfdzIndzKvdw83MAlpoo7Lck9/g3XkpYS0y3IEN1rusvccn29
l4m1TNhNi6rDNbvPLi3em8myxcvdY6ynlkuwkaqtc0rdraxGgWrZgkqVwczezW23OY3a3UKQ
FK3SWBmyB3zGm/KK4QhxAKq5jc3f7a3ToMq5f8yhfa3S07Z6YS1VbA26xAlKijcmVP0vvg3h
lhyHflzV8KrFir1W6nllYBqhJbyPoOvCN21MkZyc/GjiK0yRh73W+yrDQabeuxzRG/6Dxhze
wgt0pdzZPN7jMimaQA7UagvWONxXoZnknC2UTW68k72HTv7kVnq2iirlVK6wgL3SGZ6h5JjY
q0e/3Ae/tEzf7I2/5bzNi1zAcai3/k7tpHl+3T+cSVlJqesMXQceRfwj5pRp3ooes4ze6HAJ
6M4N6ZRe6ZZ+6Zi+ljL93Mw2wGNailjy6NexpyQc4t/8lwk86Q9MzyC34PdtTP5K4C5B5733
EjUc0vkdrv3cw4OIrjBOoEJcuo4n6mgKz31+xEEJ0IWKwPBtf+GUzPUMuEsSPH6rvwRU7ThU
sgB86lO8gls8JWMVjI3ozkntrDiOt1ZN0mZtcfI6ncnh2wfp1/M6k82KbvQLgVg94qmy6RHs
1bQEyawlyWkevkGI5bab5iVs1t0V7YkshO6Gu3Fkl7zqndBuz+bZxGEey9wLkYeG07GenhU+
a/VK2UIm/so3d+Qkv9ch2eWsXsnVW8y6nqkfv9gNfdJJGfDjney4vNJueuYAbuMq/+I23vJ7
TL5g5epxHoOercxEvcxgm71fdLzYx3mvC7FQj3KPSZ84jMF23tqJLrslOs5ySOh/Xs479Hyt
KH0MLMXozPaFPqmCKO8enOl8ReyNaffPQfdpRustLSp8r/eeqOpB1Cz8XnlGW/iAn/iKv/iM
3/iO//iQH/mSP/mUX/nPK92p3qsSqOMNxfmZ/8igz4Cev/mdX/qfL/qmT/qnr1uov/qW//qw
H/uyP/u0X/u2f/u4n/u6v/u83/u+f894bxLBjxWJBs4IDUAsTly/b93DD+Uy/uF6a/7tmxWY
f5/71Y+mMTHL0hj9O/my13/77okmxr91CT65zbfbP23+v/jM7N992rv8Yx71s1ObYI9UDZb0
Ps9//+7IdTzJ/l9+ABEgAICBAgEcPGgQ4UKGCxU2hBhR4kSKFS1exJhR40aOHT1+BBlS5EiS
JU2eRPmQosKHLAcSFBjzpcyYCQvCROjS4cuKKnPy1Inzp82dIA0WnHlTJ1KiTHE6PSo0qk+f
PXmixJpV61auXb1+BRtWrNiqEYMKLdqw7FSgSdNahdjSLVqpV8tmlEtUb160Z/3OpRsY7ljC
hQ0fRpxY8WLGca9O/Kv2sV6GbIfSvSvZ8eWzdd9W/p68eW9bypH7AjZ9GWPmxq1dv4YdW/bs
j6zT8n1r2vLoorb5/gbseSjV0Jp5HxeeXDfpzxZt04YeXfp06tVDPrdZM/tkmju1n/75Pbxz
md5V1gQOuvjF7uHPl3dvF/52+eJprjdvXf9+/v39/6cMLOwAJLBAAw9EMEEFsRrQpAYXhDBC
CSeksELX5vMKQws35LBDDz8EMUQRRySxRBNPRDFFFVdksUUXX4QxRhlnpDEl/Iwj78baHhTv
tbXM0tGqIE8q7sHCihyyRiWXHKnBHldKkiMjjRyrqruoFE1AJGe7MkomvwRztSE1hFKrKb1c
DEu80LyOzTTdFDNMOZnk/jFK4uxDjUwn8eQzrycd++6oO80blND8cISyz/rk0rDH9p56TtBF
J43vMTxhqi8wNefkFMQ618yNudQChMwp8E5NDkjV0LOUuy1XdRVRidJD7j1VYeVMx6BoxezV
XJHrNNgaP42zUlGTepTUWxmF775jyxSNOFlVE4y+aW8ltDPQsEVV22iRna9LboXzVlhzXSSW
PfmWDe5a43Br7tdSx41XXGrljXdWW92ttldc+72tXe/clZZcOM9FeMN0ycvX4HkHg/defOlV
VmJ7K/b2TIkBvrhbgd/9uLmOHRZs04RPPnDhwUpb9N+NQf4Xt3JDfblkUwOk1cogeR1V0G1d
/p45YJaHHq7Vn3eNFWWlPxzwvhwp/Tk+9Xb22Vqpr06UWUBdbfU9PnvFLlmx9bwTamDZxRpT
nbte97Q/l4Y7bv1Mlls6uuvGO++w7ta7taD7Bjxwst4WnDoyC0c8ccUXZ7xxxx+HPHLJJ6e8
cssvxzxzzTfnvHPPPwc9dNFHJ710009HPXXVE3aWPpfaa11t7WKn3WnZX2/W9tph17133n/P
HfjZfQ+++OGFx/1445NnHlzln2/edeejv336g1fHPnvtt+e+e++/Bz988ccnv3zzz0c/ffXX
Z79999+HP37556e/fvvvxz9//feP7XAxFR2PZACoHgGqi2/QuRvh/nK0kQMOToFRG5iQIrUW
//EvQazxzbOIRjNUbWxfFEMQ3+hGpQZqqWYR5JfL9IWjElpQNpmZoAeZw8GIVatgWXrRCK9n
txnqa2RZimHUWuhC2IzsUTX0WtuU07JDNWyIXTkiUrrWmz1NzWyp8iEVM8UsJuIrWTjToKa4
9iqeteWDTySi30Jzw6WIcVtJ5CJpbEVBHCJwhtoqWNOUmJqqMWxgSFMhGGtltOGAR2dvXKMc
DbkuPwEsjQA6JAQL+cGJyXCQFbNZdejoRqH5kWhdUhkg/SXAfVHvdk0BGw4zxshUdnI3j7xg
IiW5wU1u8mh5wpgsNZlHQlZyhTFDUiiT/lYoYImSW/D6Uyl7uUFM3ZKZsDRQx2w5s3LVEpeZ
rON0lCnJv32GV4gslsU+9k1jqrKHyWwbJZnpqLnUEJqJseXKWBhGPgpsmte8YQpnaUNddkRm
7eKlumh4x5DJKpL/PFu4eghEOSbtkvMsmisX+k549lOC2BpboGwnuyZuh4CM6mBHobXPeEoJ
Q188aUE7mlGQOtI9L7WiocaTT45KkKCVmqmuFAqrAVLUpyJBo3WC+lOi0miohtthUZVqImfh
p4IG/CKDYufPBy7VqlfFala1ulWudtWr2nuqTQ16ODjK1CNhVcxRAaVPsbaVqlW9F0uX+dWT
YfBGyDzjFD85/tEUqrVNDNxhJKl6wpCGM2x5faZf6ToiGOqUp3vsYhk9ydbDkDCpQ3TnLwFL
WLUNVJyLrauvrBZSxDblph570g8bozFjPY2AZqWWZOf5tuXEFbLPdClowVTS9NzMX1DBpami
+FnKGkZlJsVmYlnpJ7YF0pCLHGvuCJJc3QpLsJb07RzrwrvpLieq1L1QkhJoz0nFEZVe++VU
BXkzdKZXKQ6tbrB42898IvG038xmbitrJ7Y9cJUNEyQY1xM0NmaKX6PCZHx3K9p7QtC+wPSl
E5NqJi+Z7L8nLG123EsvvFrUmcpSrIL3m9+SgnjA911ohoGGz3OeOJwABmqF4XRh/twKsaEQ
PhstfdsvhMJYxJD0cC6z6T8uwnajUVVoT2uKSbRaksIa2RSrVtrk4bJMyT7s8Sk9Clv9/tjL
XwZzmMU8ZjKX2cxnRnOa1bxmNrfZzW+Gc5zlPGc619nOd8ZznvW8Zz732c9/BnSgBT1oQhfa
0IdGdKIVvWhGN9rRj4Z0pCU9aUoDuskadhAF4drM/K71tQv8tJAKuCO4onRPgV3b/0bt1gBm
7YpAimKpyQbVV8O6rKz+7v8sTOWUyvrKWQx1olbtai5DOaUJLq6xIVqmVMNljlT7LbSffVa+
chBSDNt1tLHNSMeaeGUIXnZmVShrL96VnuYu92CR/TCX/spWs+DWzLSdze1vX3OzxXzxSPVd
46NNzY/p/PdtAs4ZanOWhgNXN8AhJvCRXhej9v53tVd82HSzG96eXfe73STuGmew4g9TOLRC
rnF+K5vHjfq1HlVMsT6y28ck5W+nbX3ayR53yS43uJM9mcR6l/xbhI0YxR9K8sLa2Oej5TjS
Jd5xdA9dsy/PVxWdPnO0LfvaR5/XrUsV0Kz527UixbLXe+46gcL0ota2tdi7DnYs09umbtkx
yePeG04y2zNznyTccyvXprstiH6nGjtjKNxcm33LZzc8sXFq8cjSt51mvPTPiz5L9bI85snm
p67bK8+M10vGMiexeDXI2lfq/rv0m8mutO/e7veet+8lhjnQeyd7nasq7n+Heu0bHuR9ftjo
S2zS4zlr18nmXMj57nzGcW988HI++cffufBBNXluLp200J56uK3vTo9b3fK0h/7DQR9+53e5
6N0HuV326nM9Zr+v2O/995Fv/uUT7PK51/2+n5+zz1NfZNtPMfi7OBxjvfyLvXVrMMYbP+7r
tvgLPcPivZfjP3nJsuQzpvqDOth7OubTQIZiqwp0vqTLvPmTOpIpO/+zLfCrOwVEQXcTPwdc
PwQ8t907ugcrP5srQYfzwA7qNfQqMmr7NVJKu61rrq9LvLBjO6o7wq1RHqgiJZ0qGydMQib8
Iyjs/q8TTJu2yxZc47UgfMIpjKksVMLRIsJao8IlFEIwFKnIYylaK7ZKg8M4lMM5pMM6tMM7
xMM81MM9RJ/CM7JLQ6cxaTZQQyHFazVD3DQJexoz/EJMc0MYFMMYS8QzNMTcm0RYGzZhCzbA
EjyjSLJ7i8RGJEMtdMRFLC4/BMIoA8CPW6EOpKJXnDdYZMGrm8UzSaQGHEAdg8BCJDqSEMEX
7MVSbMWDabmWG0ZZLDuEUqdalLHbYsGkA8FZ5DQaLIlf3MFktD6pGL+9YDiR68ZeZImxM7/O
UrsXhEaaE8fIY77oU7cCFDDsI8aZ+Mb0mkdqPJW5Akf+aixqPEfnykfL/sq04dup/UNHEOK1
bYw60fNHYFRHafm7XEQtAcRH0+vCaBTFfhwaoQtD/RtHVzymgsxAgrI5GWTFazxIUmGtURxD
jAQ8QbQiczukCYpCIzw8u8MdgSI8+ksnxwKu7rJC5lrEiXw6lmwj9DMvRFSpmmxBwRPEmcTC
p9guF7PJG3tKcsy61ZNJjdKvjXq+UXJHrIRJsoK/bTyoseTACEQ9FKQ7/BpKrkzLory/bqq+
fMPB1itDjwQOVGw+jqzL6VvLVbxKtgShAuxJvNtBYaLL+/tLjoRE9NtALJK/qtTJhTTJpHyZ
h4S4sUPM4utIx2NMH7NB/UtJ/BvBxKTMvUMx/skkSfcjus0MQcU8TdT8TIGEmRuETYKMTWuT
SybDxczkR9jUSNJMwMfUp9DEuXEsTc5ETq8UN40UTJkzSt98RuA0y64cTmCkTW97zc7zyANk
R9yMwfKTTdY0J/AMyZLUPhXUQe/jTofCwL4ERYvssh5rv9h0QYo0T4O7z/RUvh4MSsijSQ3L
IKdcOzSkRDbswcBjSi70tStEPLK7S8hTUEbcSKusRKVMwzcsR0Bc0PhMMvhi0MP60AnV0A2t
yJd0tR+sRL3kwxZ10ReF0RiV0Rml0Rq10RvFUV/kUK5RNU/kUQPKRFJUSUzcRCY0JSG9OWND
xUvcuhL9QybN0Sfr/k+EjKiCkzdmc7vppM1lJM50gUjiPM4dsc8ZjNKKUkHS1MaCmy6CWzg2
1dIpXdPOpNLwVJPR/KsaJNMy/Yoq+0o01bTgPMs53c9pgc8T/FI+lUIDzVCilE49larHGlCN
QiuUkz0CJcJyLMMtvFRNvcvFW9ElPZaD7E5aPL14A0tHzRC3XE3gE83+g8SE3MUPdM/b/Eq8
VNXxVNENc72p3FVU5QoMxLjx9FO0fEBDJVbtlNPi5CvHHEwKtMx6+s119FXkms17zMb1DNNC
FUcJnFW/BM1l7TswlSg4lU8CDDE9NU5zvNZu5UtazUEQ5TDAZNVghNN51VW5hNY3Xc5p4OVE
njPFUAQ7vUQ5lSvCf8XQrRHFTAXYJ21KrVNYAYVCwDPYJOXXirXYi8XYjNXYjeXYjvXYjwXZ
kBXZkSXZkjXZk0XZlFXZlWXZlnXZl4XZmJXZmaXZmrXZm8XZnNXZneXZnvXZn93TUa1GYwRa
NBPa4JvGrJuwooWlc5VWcGLa6hpESMlTmlJSdYzaopqv47jSod3XrPWprTVBYdTRrwXbdxLb
ckpar3Xas3WftJW+Q3za1nJbr4LbYtoxHTLbuiWigd3JnMK6zWpbviXcwoWfplpaw70zxFXc
xnVcYQkIADs=
--------------090609050908020704000801
Content-Type: text/plain;
 name="ldt.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ldt.c"

/*
 * Copyright (c) 2005, Zachary Amsden (zach@vmware.com)
 * This is licensed under the GPL.
 */

#include <stdio.h>
#include <signal.h>
#include <asm/ldt.h>
#include <asm/segment.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sched.h>
#define __KERNEL__
#include <asm/page.h>

/*
 * Spin modifying LDT entry 1 to get contention on the mm->context
 * semaphore.
 */
void evil_child(void *addr)
{
	struct user_desc desc;

	while (1) {
		desc.entry_number = 1;
		desc.base_addr = addr;
		desc.limit = 1;
		desc.seg_32bit = 1;
		desc.contents = MODIFY_LDT_CONTENTS_CODE;
		desc.read_exec_only = 0;
		desc.limit_in_pages = 1;
		desc.seg_not_present = 0;
		desc.useable = 1;
		if (modify_ldt(1, &desc, sizeof(desc)) != 0) {
			perror("modify_ldt");
			abort();
		}
	}
	exit(0);
}

void catch_sig(int signo, struct sigcontext ctx)
{
	return;
}

void main(void)
{
        struct user_desc desc;
        char *code;
        unsigned long long tsc;
	char *stack;
	pid_t child; 
	int i;
	unsigned long long lasttsc = 0;

        code = (char *)mmap(0, 8192, PROT_EXEC|PROT_READ|PROT_WRITE,
                                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

	/* Test 1 - CODE, 32-BIT, 2 page limit */
        desc.entry_number = 0;
        desc.base_addr = code;
        desc.limit = 1;
        desc.seg_32bit = 1;
        desc.contents = MODIFY_LDT_CONTENTS_CODE;
        desc.read_exec_only = 0;
        desc.limit_in_pages = 1;
        desc.seg_not_present = 0;
        desc.useable = 1;
        if (modify_ldt(1, &desc, sizeof(desc)) != 0) {
                perror("modify_ldt");
		abort();
        }
        printf("INFO: code base is 0x%08x\n", (unsigned)code);
        code[0x0ffe] = 0x0f;  /* rdtsc */
        code[0x0fff] = 0x31;
        code[0x1000] = 0xcb;  /* lret */
        __asm__ __volatile("lcall $7,$0xffe" : "=A" (tsc));
        printf("INFO: TSC is 0x%016llx\n", tsc);

	/*
	 * Fork an evil child that shares the same MM context
	 */
	stack = malloc(8192);
	child = clone(evil_child, stack, CLONE_VM, 0xb0b0);
	if (child == -1) {
		perror("clone");
		abort();
	}

	/* Test 2 - CODE, 32-BIT, 4097 byte limit */
        desc.entry_number = 512;
        desc.base_addr = code;
        desc.limit = 4096;
        desc.seg_32bit = 1;
        desc.contents = MODIFY_LDT_CONTENTS_CODE;
        desc.read_exec_only = 0;
        desc.limit_in_pages = 0;
        desc.seg_not_present = 0;
        desc.useable = 1;
        if (modify_ldt(1, &desc, sizeof(desc)) != 0) {
                perror("modify_ldt");
		abort();
        }
        code[0x0ffe] = 0x0f;  /* rdtsc */
        code[0x0fff] = 0x31;
        code[0x1000] = 0xcb;  /* lret */
        __asm__ __volatile("lcall $0x1007,$0xffe" : "=A" (tsc));

	/*
	 * Test 3 - CODE, 32-BIT, maximal LDT.  Race against evil
	 * child while taking debug traps on LDT CS.
	 */
	for (i = 0; i < 1000; i++) {
		signal(SIGTRAP, catch_sig);
		desc.entry_number = 8191;
		desc.base_addr = code;
		desc.limit = 4097;
		desc.seg_32bit = 1;
		desc.contents = MODIFY_LDT_CONTENTS_CODE;
		desc.read_exec_only = 0;
		desc.limit_in_pages = 0;
		desc.seg_not_present = 0;
		desc.useable = 1;
		if (modify_ldt(1, &desc, sizeof(desc)) != 0) {
			perror("modify_ldt");
			abort();
		}
		code[0x0ffe] = 0x0f;  /* rdtsc */
		code[0x0fff] = 0x31;
		code[0x1000] = 0xcc;  /* int3 */
        	code[0x1001] = 0xcb;  /* lret */
		__asm__ __volatile("lcall $0xffff,$0xffe" : "=A" (tsc));
		if (tsc < lasttsc) {
			printf("WARNING: TSC went backwards\n");
		}
		lasttsc = tsc;
	}
	if (kill(child, SIGTERM) != 0) {
		perror("kill");
		abort();
	}
	if (fork() == 0) {
		printf("PASS: LDT code segment\n");
	}
}

--------------090609050908020704000801--
